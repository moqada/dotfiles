# コマンド完了通知 (zsh-notify 代替)
# Ghostty + tmux 環境で動作
#
# 機能:
# - OSC 777 で macOS 通知を送信（Ghostty が自動でフォーカス判定）
# - tmux ステータスバー用のフラグファイルを作成
# - tmux では allow-passthrough all が必要

# 設定
NOTIFY_IGNORE_COMMANDS=(vim nvim less man ssh tmux)

# OS 通知送信（OSC 777 を使用）
_notify_send() {
  local title="$1"
  local message="$2"
  # 特殊文字をエスケープ（; などが OSC シーケンスを壊す可能性）
  message="${message//;/,}"
  if [[ -n "$TMUX" ]]; then
    # tmux 内ではパススルー形式
    printf '\ePtmux;\e\e]777;notify;%s;%s\a\e\\' "$title" "$message"
  else
    # tmux 外では直接 OSC 777
    printf '\e]777;notify;%s;%s\a' "$title" "$message"
  fi
}

# tmux の window 通知用ベル
_notify_bell() {
  [[ -z "$TMUX" ]] && return
  printf '\a' > /dev/tty 2>/dev/null || printf '\a'
}

# preexec: コマンド開始時刻を記録
_notify_preexec() {
  _NOTIFY_CMD_START=$EPOCHSECONDS
  _NOTIFY_CMD="$1"
}

# precmd: コマンド完了時の処理
_notify_precmd() {
  local exit_status=$?
  local elapsed=$(( EPOCHSECONDS - ${_NOTIFY_CMD_START:-$EPOCHSECONDS} ))

  # 開始時刻がなければスキップ（初回起動時など）
  [[ -z "$_NOTIFY_CMD_START" ]] && return

  # 開始時刻をリセット
  unset _NOTIFY_CMD_START

  # 無視コマンドはスキップ
  local cmd_name="${_NOTIFY_CMD%% *}"
  (( ${NOTIFY_IGNORE_COMMANDS[(I)$cmd_name]} )) && return

  # 通知
  local status_msg
  if [[ $exit_status -eq 0 ]]; then
    status_msg="✓"
  else
    status_msg="✗"
  fi
  _notify_bell
  _notify_send "コマンド完了" "${status_msg} ${_NOTIFY_CMD} (${elapsed}s)"
}

add-zsh-hook preexec _notify_preexec
add-zsh-hook precmd _notify_precmd
