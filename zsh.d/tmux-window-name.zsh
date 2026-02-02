# Load repo aliases from local config file
typeset -gA TMUX_REPO_ALIASES
if [[ -f ~/.tmux-repo-aliases ]]; then
  while IFS='=' read -r key value; do
    [[ -n "$key" && ! "$key" =~ ^# ]] && TMUX_REPO_ALIASES[$key]=$value
  done < ~/.tmux-repo-aliases
fi

# tmux window/pane name auto-setting
# - pane index 1: sets window name
# - pane index 2+: sets pane name
# If .tmux-window-name exists, use its content. Otherwise, use directory name.
function _set_tmux_window_name() {
  # Only run inside tmux
  if [[ -n "$TMUX" ]]; then
    local name_file=".tmux-window-name"
    local name
    if [[ -f "$name_file" ]]; then
      name=$(cat "$name_file")
    else
      name=${PWD:t}  # basename of current directory
      # Apply repo alias if defined (check worktree only if no direct match)
      if (( ${+TMUX_REPO_ALIASES[$name]} )); then
        name=${TMUX_REPO_ALIASES[$name]}
      else
        local git_common_dir=$(git rev-parse --git-common-dir 2>/dev/null)
        if [[ -n "$git_common_dir" && "$git_common_dir" != ".git" ]]; then
          # worktree: /path/to/main-repo/.git -> main-repo
          local repo_name=${git_common_dir:h:t}
          if (( ${+TMUX_REPO_ALIASES[$repo_name]} )); then
            name=${TMUX_REPO_ALIASES[$repo_name]}
          fi
        fi
      fi
      # Add git branch if in a git repository
      local branch=$(git symbolic-ref --short HEAD 2>/dev/null)
      if [[ -n "$branch" ]]; then
        # Shorten "feature" prefix to "f"
        branch=${branch/#feature/f}
        name="$name:$branch"
      fi
    fi
    local pane_index=$(tmux display-message -p '#{pane_index}')
    if [[ "$pane_index" == "1" ]]; then
      tmux rename-window "$name"
    else
      tmux select-pane -T "$name"
    fi
  fi
}

add-zsh-hook chpwd _set_tmux_window_name

# Run on shell startup for the initial directory
_set_tmux_window_name
