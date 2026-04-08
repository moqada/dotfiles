#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# ── Extract data using jq ──────────────────────────────────────────
cwd_full=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')
project_dir=$(echo "$input" | jq -r '.workspace.project_dir // ""')
model=$(echo "$input" | jq -r '.model.display_name // "Claude"')
model_id=$(echo "$input" | jq -r '.model.id // ""')

# Cost & duration
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
duration_ms=$(echo "$input" | jq -r '.cost.total_duration_ms // 0')
api_duration_ms=$(echo "$input" | jq -r '.cost.total_api_duration_ms // 0')
lines_added=$(echo "$input" | jq -r '.cost.total_lines_added // 0')
lines_removed=$(echo "$input" | jq -r '.cost.total_lines_removed // 0')

# Context window
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // 0')
input_tokens=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
output_tokens=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0')

# Cache info
cache_read=$(echo "$input" | jq -r '.context_window.current_usage.cache_read_input_tokens // 0')
cache_create=$(echo "$input" | jq -r '.context_window.current_usage.cache_creation_input_tokens // 0')
current_input=$(echo "$input" | jq -r '.context_window.current_usage.input_tokens // 0')

# Optional fields
vim_mode=$(echo "$input" | jq -r '.vim.mode // empty' 2>/dev/null)
agent_name=$(echo "$input" | jq -r '.agent.name // empty' 2>/dev/null)

# Reasoning effort — check transcript first (session-scoped), fallback to settings (global)
transcript_path=$(echo "$input" | jq -r '.transcript_path // empty' 2>/dev/null)
effort_level=""
if [ -n "$transcript_path" ] && [ -f "$transcript_path" ]; then
    # Search transcript backwards for "Set model to ... with <effort> effort"
    effort_level=$(tail -r "$transcript_path" 2>/dev/null | grep -oE 'Set model to[^<]*with (low|medium|high|max) effort' | head -1 | grep -oE '(low|medium|high|max) effort' | cut -d' ' -f1)
fi
# Fallback to settings.json if not found in transcript
[ -z "$effort_level" ] && effort_level=$(jq -r '.effortLevel // empty' ~/.claude/settings.json 2>/dev/null)

# ── ANSI color codes ───────────────────────────────────────────────
BOLD=$'\x1b[1m'
DIM=$'\x1b[2m'
GREEN=$'\x1b[32m'
YELLOW=$'\x1b[33m'
RED=$'\x1b[31m'
CYAN=$'\x1b[36m'
MAGENTA=$'\x1b[35m'
BLUE=$'\x1b[34m'
WHITE=$'\x1b[37m'
RESET=$'\x1b[0m'

# ── Helper functions ───────────────────────────────────────────────
format_tokens() {
    local tokens=$1
    if [ "$tokens" -ge 1000000 ] 2>/dev/null; then
        printf "%.1fM" "$(echo "$tokens / 1000000" | bc -l)"
    elif [ "$tokens" -ge 1000 ] 2>/dev/null; then
        printf "%.1fK" "$(echo "$tokens / 1000" | bc -l)"
    else
        echo "$tokens"
    fi
}

format_duration() {
    local ms=$1
    local total_sec=$((ms / 1000))
    local h=$((total_sec / 3600))
    local m=$(((total_sec % 3600) / 60))
    local s=$((total_sec % 60))
    if [ "$h" -gt 0 ]; then
        printf "%dh%02dm" "$h" "$m"
    elif [ "$m" -gt 0 ]; then
        printf "%dm%02ds" "$m" "$s"
    else
        printf "%ds" "$s"
    fi
}

progress_bar() {
    local pct=$1
    local width=${2:-15}
    local filled=$((pct * width / 100))
    local empty=$((width - filled))
    local bar=""
    [ "$filled" -gt 0 ] && bar=$(printf "%${filled}s" | tr ' ' '█')
    [ "$empty" -gt 0 ] && bar="${bar}$(printf "%${empty}s" | tr ' ' '░')"
    echo "$bar"
}

usage_color() {
    local pct=$1
    if [ "${pct:-0}" -ge 80 ] 2>/dev/null; then
        echo "$RED"
    elif [ "${pct:-0}" -ge 50 ] 2>/dev/null; then
        echo "$YELLOW"
    else
        echo "$GREEN"
    fi
}

# Format Unix timestamp to local short date (e.g. "3/11 18:00")
format_reset_time() {
    local ts="$1"
    [ -z "$ts" ] || [ "$ts" = "null" ] && return
    # macOS date -r accepts Unix timestamp
    date -r "$ts" "+%-m/%-d %H:%M" 2>/dev/null || \
        date -d "@$ts" "+%-m/%-d %H:%M" 2>/dev/null
}

# ── Format cost ────────────────────────────────────────────────────
cost_display=$(echo "$cost" | awk '{if ($1 < 0.01) printf "%.2f¢", $1*100; else printf "$%.2f", $1}')

# ── Format duration & API ratio ────────────────────────────────────
duration_display=$(format_duration "$duration_ms")
api_pct=0
if [ "$duration_ms" -gt 0 ] 2>/dev/null; then
    api_pct=$((api_duration_ms * 100 / duration_ms))
fi

# ── Format tokens ──────────────────────────────────────────────────
input_display=$(format_tokens "$input_tokens")
output_display=$(format_tokens "$output_tokens")

# ── Cache rate ─────────────────────────────────────────────────────
cache_pct=0
cache_total=$((current_input + cache_create + cache_read))
if [ "$cache_total" -gt 0 ] 2>/dev/null; then
    cache_pct=$((cache_read * 100 / cache_total))
fi

# ── Context usage color ────────────────────────────────────────────
pct_int=${used_pct%.*}
ctx_color=$(usage_color "${pct_int:-0}")

# ── Git information (with cache) ───────────────────────────────────
STATUSLINE_CACHE_DIR="/private/tmp/claude"
mkdir -p "$STATUSLINE_CACHE_DIR" 2>/dev/null
GIT_CACHE_FILE="${STATUSLINE_CACHE_DIR}/statusline-git-cache-$(echo "$cwd_full" | md5 -q 2>/dev/null || echo "$cwd_full" | md5sum 2>/dev/null | cut -d' ' -f1)"
GIT_CACHE_MAX_AGE=5

git_cache_is_stale() {
    [ ! -f "$GIT_CACHE_FILE" ] || \
    [ $(($(date +%s) - $(stat -f %m "$GIT_CACHE_FILE" 2>/dev/null || stat -c %Y "$GIT_CACHE_FILE" 2>/dev/null || echo 0))) -gt $GIT_CACHE_MAX_AGE ]
}

git_branch=""
git_status_str=""
git_upstream=""
repo_name=""

if cd "$cwd_full" 2>/dev/null && git rev-parse --is-inside-work-tree &>/dev/null; then
    if git_cache_is_stale; then
        branch=$(git branch --show-current 2>/dev/null || echo "detached")
        rname=$(basename "$(git rev-parse --show-toplevel 2>/dev/null)" 2>/dev/null)

        # Upstream
        up=""
        if git rev-parse --abbrev-ref --symbolic-full-name @{u} &>/dev/null; then
            ahead=$(git rev-list --count @{u}..HEAD 2>/dev/null || echo "0")
            behind=$(git rev-list --count HEAD..@{u} 2>/dev/null || echo "0")
            [ "$ahead" -gt 0 ] && up="↑${ahead}"
            [ "$behind" -gt 0 ] && up="${up}↓${behind}"
        fi

        # Status
        st=""
        git diff --cached --quiet 2>/dev/null || st="${st}●"
        git diff --quiet 2>/dev/null || st="${st}✚"
        [ -n "$(git ls-files --others --exclude-standard 2>/dev/null | head -1)" ] && st="${st}…"
        [ -z "$st" ] && st="✔"

        echo "${branch}|${rname}|${up}|${st}" > "$GIT_CACHE_FILE"
    fi

    IFS='|' read -r git_branch repo_name git_upstream git_status_str < "$GIT_CACHE_FILE"
fi

# ── Usage limits (from rate_limits in statusline input) ────────────
five_hour_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
five_hour_reset_ts=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
seven_day_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
seven_day_reset_ts=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // empty')

five_hour_reset=""
[ -n "$five_hour_reset_ts" ] && five_hour_reset=$(format_reset_time "$five_hour_reset_ts")
seven_day_reset=""
[ -n "$seven_day_reset_ts" ] && seven_day_reset=$(format_reset_time "$seven_day_reset_ts")

# ── Shorten directory ──────────────────────────────────────────────
cwd_display="${cwd_full/#$HOME/\~}"

# ── Line delta ─────────────────────────────────────────────────────
net_lines=$((lines_added - lines_removed))
if [ "$net_lines" -ge 0 ]; then
    net_display="+${net_lines}"
else
    net_display="${net_lines}"
fi

# ── Build optional badges ──────────────────────────────────────────
badges=""
# vim mode is already displayed by Claude Code natively — skip to avoid duplication
[ -n "$agent_name" ] && badges="${BLUE}⚡${agent_name}${RESET} "

# ══════════════════════════════════════════════════════════════════════
# Line 1: Session info — model, cost, duration, API ratio
# ══════════════════════════════════════════════════════════════════════
line1="${badges}${BOLD}${model}${RESET}"
[ -n "$effort_level" ] && line1="${line1} ${DIM}effort:${effort_level}${RESET}"
line1="${line1} │ ${YELLOW}${cost_display}${RESET}"
line1="${line1} · ${DIM}${duration_display}${RESET}"
[ "$api_pct" -gt 0 ] && line1="${line1} ${DIM}(API ${api_pct}%)${RESET}"

# ══════════════════════════════════════════════════════════════════════
# Line 2: Context bar, tokens, cache
# ══════════════════════════════════════════════════════════════════════
bar=$(progress_bar "${pct_int:-0}")
line2="🧠 ${ctx_color}${bar}${RESET} ${ctx_color}${pct_int:-0}%${RESET}"
line2="${line2} │ IN:${input_display} OUT:${output_display}"
[ "$cache_pct" -gt 0 ] && line2="${line2} cache:${cache_pct}%"

# ══════════════════════════════════════════════════════════════════════
# Line 3: Git + directory + line delta
# ══════════════════════════════════════════════════════════════════════
line3="📂 ${DIM}${cwd_display}${RESET}"
if [ -n "$git_branch" ]; then
    line3="${line3} │ 🌿 ${CYAN}${git_branch}${RESET}"
    [ -n "$git_upstream" ] && line3="${line3} ${git_upstream}"
    line3="${line3} ‹${git_status_str}›"
fi
if [ "${lines_added:-0}" -gt 0 ] || [ "${lines_removed:-0}" -gt 0 ]; then
    line3="${line3} │ ${GREEN}+${lines_added}${RESET} ${RED}-${lines_removed}${RESET} ${DIM}(Δ${net_display})${RESET}"
fi

# ══════════════════════════════════════════════════════════════════════
# Line 4: Usage limits — 5-hour session & 7-day weekly
# ══════════════════════════════════════════════════════════════════════
line4=""
if [ -n "$five_hour_pct" ] || [ -n "$seven_day_pct" ]; then
    # 5-hour session limit
    if [ -n "$five_hour_pct" ]; then
        fh_int=${five_hour_pct%.*}
        fh_color=$(usage_color "$fh_int")
        fh_bar=$(progress_bar "$fh_int" 10)
        line4="⏱ 5h ${fh_color}${fh_bar}${RESET} ${fh_color}${fh_int}%${RESET}"
        [ -n "$five_hour_reset" ] && line4="${line4} ${DIM}reset ${five_hour_reset}${RESET}"
    fi

    # 7-day weekly limit
    if [ -n "$seven_day_pct" ]; then
        sd_int=${seven_day_pct%.*}
        sd_color=$(usage_color "$sd_int")
        sd_bar=$(progress_bar "$sd_int" 10)
        line4="${line4} │ 📅 7d ${sd_color}${sd_bar}${RESET} ${sd_color}${sd_int}%${RESET}"
        [ -n "$seven_day_reset" ] && line4="${line4} ${DIM}reset ${seven_day_reset}${RESET}"
    fi

fi

# ══════════════════════════════════════════════════════════════════════
# Output
# ══════════════════════════════════════════════════════════════════════
echo -e "$line1"
echo -e "$line2"
echo -e "$line3"
[ -n "$line4" ] && echo -e "$line4"
