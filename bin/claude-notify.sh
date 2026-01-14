#!/bin/bash
# Claude Code 完了通知スクリプト
#
# 使用方法:
# Claude Code の /hooks で Stop フックに登録
#
# 機能:
# - OSC 777 で macOS 通知を送信（Ghostty が自動でフォーカス判定）

# メイン処理
main() {
  # OS 通知（OSC 777 を使用）
  if [[ -n "$TMUX" ]]; then
    # tmux 内ではパススルー形式
    printf '\ePtmux;\e\e]777;notify;Claude Code;タスクが完了しました\a\e\\'
  else
    # tmux 外では直接 OSC 777
    printf '\e]777;notify;Claude Code;タスクが完了しました\a'
  fi
}

main "$@"
