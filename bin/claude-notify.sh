#!/bin/bash
# Claude Code 通知スクリプト
#
# 使用方法:
# Claude Code の hooks 設定で Notification フックに登録
#
# 機能:
# - OSC 777 で macOS 通知を送信（Ghostty が自動でフォーカス判定）
# - stdin から JSON を受け取り、notification_type に応じてタイトルを変更

# notification_type からタイトルを決定
get_title() {
  local notification_type="$1"
  case "$notification_type" in
    permission_prompt)  echo "🔐 許可が必要" ;;
    idle_prompt)        echo "⏳ 入力待ち" ;;
    auth_success)       echo "✅ 認証成功" ;;
    elicitation_dialog) echo "📝 入力が必要" ;;
    *)                  echo "Claude Code" ;;
  esac
}

# メイン処理
main() {
  local osc
  local title=""
  local message=""
  local json_input=""
  local notification_type=""

  # stdin から JSON を読み込む
  if [[ ! -t 0 ]]; then
    json_input="$(cat)"
  fi

  # JSON をパース（jq が利用可能な場合）
  if [[ -n "$json_input" ]] && command -v jq &>/dev/null; then
    message=$(echo "$json_input" | jq -r '.message // empty')
    notification_type=$(echo "$json_input" | jq -r '.notification_type // empty')
    title=$(get_title "$notification_type")
  fi

  # 引数でオーバーライド可能
  title="${1:-${title:-Claude Code}}"
  message="${2:-${message:-通知}}"

  # 特殊文字をエスケープ（; などが OSC シーケンスを壊す可能性）
  message="${message//;/,}"

  # OS 通知（OSC 777 を使用）
  if [[ -n "$TMUX" ]]; then
    # tmux 内ではパススルー形式
    osc="\ePtmux;\e\e]777;notify;${title};${message}\a\e\\"
  else
    # tmux 外では直接 OSC 777
    osc="\e]777;notify;${title};${message}\a"
  fi

  # Claude Code の hook でも通知を届けるために tty に送る
  printf '%b' "$osc" > /dev/tty 2>/dev/null || printf '%b' "$osc"
  if [[ -n "$TMUX" ]]; then
    printf '\a' > /dev/tty 2>/dev/null || printf '\a'
  fi
}

main "$@"
