# Detect React Native Metro bundler and show port in tmux window/pane name
#
# Detection strategy (no hardcoded npm scripts):
#   1. preexec checks if metro.config.js/ts exists in the project root
#   2. If the command is a package manager invocation (yarn, npm, npx, bun),
#      starts background monitoring for new listening ports in 8081-8099
#   3. Only updates the name to [metro:PORT] when an actual port is detected
#   4. precmd resets the name when the command exits

function _update_tmux_name_metro() {
  local suffix="$1"
  local pane="$2"
  local pane_index=$(tmux display-message -p -t "$pane" '#{pane_index}')
  if [[ "$pane_index" == "1" ]]; then
    local current=$(tmux display-message -p -t "$pane" '#{window_name}')
    current="${current%% \[metro*}"
    tmux rename-window -t "$(tmux display-message -p -t "$pane" '#{window_id}')" "$current [$suffix]"
  else
    local current=$(tmux display-message -p -t "$pane" '#{pane_title}')
    current="${current%% \[metro*}"
    tmux select-pane -t "$pane" -T "$current [$suffix]"
  fi
}

function _is_metro_project() {
  local root=$(git rev-parse --show-toplevel 2>/dev/null)
  [[ -z "$root" ]] && root="$PWD"
  [[ -f "$root/metro.config.js" || -f "$root/metro.config.ts" ]]
}

function _is_pkg_manager_cmd() {
  local cmd="$1"
  [[ "$cmd" == yarn* || "$cmd" == npm\ run* || "$cmd" == npx* || "$cmd" == bun* ]]
}

function _preexec_tmux_metro() {
  [[ -z "$TMUX" ]] && return

  local cmd="$1"
  _is_pkg_manager_cmd "$cmd" || return
  _is_metro_project || return

  local pane="$TMUX_PANE"

  # Snapshot ports currently listening in 8081-8099 range
  local ports_before=$(lsof -iTCP:8081-8099 -sTCP:LISTEN -P -n 2>/dev/null | awk '{print $9}' | grep -oE '[0-9]+$' | sort -un)

  # Background: wait for a new port to appear
  (
    local attempts=0
    while (( attempts < 15 )); do
      sleep 2
      local ports_now=$(lsof -iTCP:8081-8099 -sTCP:LISTEN -P -n 2>/dev/null | awk '{print $9}' | grep -oE '[0-9]+$' | sort -un)
      if [[ "$ports_now" != "$ports_before" ]]; then
        local new_port=$(comm -13 <(echo "$ports_before") <(echo "$ports_now") | head -1)
        if [[ -n "$new_port" ]]; then
          _update_tmux_name_metro "metro:$new_port" "$pane"
          return
        fi
      fi
      (( attempts++ ))
    done
  ) &!
}

function _precmd_tmux_metro_reset() {
  [[ -z "$TMUX" ]] && return
  local pane="$TMUX_PANE"
  local pane_index=$(tmux display-message -p -t "$pane" '#{pane_index}')
  local current
  if [[ "$pane_index" == "1" ]]; then
    current=$(tmux display-message -p -t "$pane" '#{window_name}')
  else
    current=$(tmux display-message -p -t "$pane" '#{pane_title}')
  fi
  if [[ "$current" == *"[metro:"* ]]; then
    _set_tmux_window_name
  fi
}

add-zsh-hook preexec _preexec_tmux_metro
add-zsh-hook precmd _precmd_tmux_metro_reset
