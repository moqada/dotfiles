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
