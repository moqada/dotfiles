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
    local selected_dir=$(ghq list | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd $(ghq root)/${selected_dir}"
        zle accept-line
    fi
    zle redisplay
}
zle -N peco-src
stty -ixon
bindkey '^s' peco-src

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

# see: http://qiita.com/kamomeZ/items/6aac2530baf42b93e336
alias look='less $(find . -type f -follow -maxdepth 1 | peco)'

# git worktree selection
function peco-worktree() {
    local selected_line=$(git worktree list | peco)
    if [ -n "$selected_line" ]; then
        local worktree_path=$(echo "$selected_line" | awk '{print $1}')
        BUFFER="cd ${worktree_path}"
        zle accept-line
    fi
    zle redisplay
}
zle -N peco-worktree
bindkey '^g' peco-worktree
