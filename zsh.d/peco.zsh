# zsh history search
function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# kill process
function peco-pkill() {
    for pid in `ps aux | peco | awk '{ print $2 }'`
    do
        kill $pid
        echo "Killed ${pid}"
    done
}
alias pk="peco-pkill"

# ghq cd
function peco-src() {
    local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle redisplay
}
zle -N peco-src
stty -ixon
bindkey '^s' peco-src

# gh-open
alias gh='gh-open $(ghq list -p | peco)'

# search shell history
# see: http://qiita.com/catfist/items/82ed3df7a0b524aeab69
function peco-history () {
  if grep -q '^[0-9]\+$' <<< "$1";then
    history $(($1 + 1))
  else
    history 1
  fi | sort -r | peco --prompt "Select history to copy:" | cut -d ' ' -f 3- | pbcopy
  pbpaste
}
alias his='peco-history'
