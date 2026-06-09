#!/bin/bash
# 通知クリック時のフォーカス移動スクリプト
#
# 使用方法:
# terminal-notifier の -execute から呼ばれる
#   claude-focus-pane.sh <pane-id>   (例: claude-focus-pane.sh %7)
#
# 機能:
# - Ghostty を前面へ出し、指定された tmux pane へ移動・フォーカスする

pane="$1"
[[ -z "$pane" ]] && exit 0

# terminal-notifier 経由の実行は PATH が最小限のため明示する
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:$PATH"

# Ghostty を前面へ
open -a Ghostty 2>/dev/null

command -v tmux &>/dev/null || exit 0

# pane が属する session へ切り替えてから window/pane を選択
sess=$(tmux display-message -p -t "$pane" '#{session_name}' 2>/dev/null)
[[ -n "$sess" ]] && tmux switch-client -t "$sess" 2>/dev/null
tmux select-window -t "$pane" 2>/dev/null
tmux select-pane -t "$pane" 2>/dev/null
