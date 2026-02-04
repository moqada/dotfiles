# for each server
ZSHRCINCPATH=$HOME'/.zshrcinc'
if test -f $ZSHRCINCPATH
then
    source $ZSHRCINCPATH
fi

case "${OSTYPE}" in 
    freebsd*|darwin*)
        alias ll='ls -lAFG'
        ;;
    linux*)
        alias ll='ls -lAF --color'
        ;;
esac

alias h='history '
alias hh='history 0 | grep -nr '

# for git
alias g='git'
alias gch='git cherry -v'
alias gcm='git commit -m'
alias gcv='git commit -v'
alias gd='git diff'
alias gdc='git diff --cached'
alias gga='git ga'
alias ggl='git gl'
alias glg='git logg | head'
alias glgg='git logg'
alias gst='git status -s -b'

# for tig
alias t='tig'
alias ta='tig --all'

# for XDG
export XDG_CONFIG_HOME=$HOME/.config

# for go
# @see: http://akirachiku.com/2016/03/01/go16-development.html
alias gp='cd $GOPATH_WORK/src/github.com/moqada'

# for vim
alias vim=nvim

# for gh-open
# Open current repository
alias gho='gh-open .'

# for grep
alias -g gr='grep --color -n '
alias -g xg='|xargs grep --color -n '

# とりあえず文字コード設定
export LANG=ja_JP.UTF-8

# @see http://journal.mycom.co.jp/column/zsh/009/index.html
export LS_COLORS=
export LS_COLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'


# compinit
# @see http://journal.mycom.co.jp/column/zsh/001/
autoload -U compinit
compinit

# history
# @see http://journal.mycom.co.jp/column/zsh/003/
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=100000
export SAVEHIST=1000000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

# see: http://qiita.com/yoshikaw/items/c8661ef83d6301ffb53c
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_space
setopt inc_append_history
alias ht='history -t "%Y-%m-%d %H:%M:%S"'
function history-all { history 1 }

# history backup
source ~/.zsh.d/history-backup.zsh

# Key-Binds
# -e = Emacs / -v = Vi
# @see http://journal.mycom.co.jp/cgi-bin/print?id=41896
bindkey -v
setopt autocd

export EDITOR=nvim

# historical backward/forward search with linehead string binded to ^P/^N
# 履歴検索。「vi」と打った状態でCtrl+P/Nでviから始まるコマンド履歴を検索
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# インクリメンタル履歴検索
bindkey "^R" history-incremental-search-backward

# 同一ホスト内での履歴の共有
setopt share_history

# hook
autoload -Uz add-zsh-hook

# lessを常にカラー表示に
export LESS='-R'

# for homebrew on M1 Mac
[ -d /opt/homebrew ] && export PATH=/opt/homebrew/bin:$PATH

# for zshinit
source /opt/homebrew/opt/zinit/zinit.zsh

# for git-prompt
zinit ice atload'!_zsh_git_prompt_precmd_hook' lucid
zinit load woefe/git-prompt.zsh
source ~/.zsh.d/git-prompt.zsh

# for nvm
export NVM_COMPLETION=true
zinit load lukechilds/zsh-nvm

# for rbenv
export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"

# for homebrew
export PATH=/usr/local/sbin:$PATH
# for homebrew-cask
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# for jdk from homebrew
# export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# include private settings
ZSHRCLOCAL_PATH=$HOME/.zshrc.local
if [ -f $ZSHRCLOCAL_PATH ]; then
    source $ZSHRCLOCAL_PATH
fi

# for travis gem
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

# for go
export PATH=$(go env GOPATH)/bin:$PATH

# for gom
export GO15VENDOREXPERIMENT=1 

# for peco
source ~/.zsh.d/peco.zsh

# for tmux window name
source ~/.zsh.d/tmux-window-name.zsh

# for command notify (zsh-notify alternative for Ghostty)
source ~/.zsh.d/command-notify.zsh

# for vim
[ -d /opt/vim ] && export PATH=/opt/vim/bin:$PATH


# for React Native (Android Studio on Mac)
export ANDROID_HOME=$HOME/Library/Android/sdk
PATH=$PATH:$ANDROID_HOME/emulator
PATH=$PATH:$ANDROID_HOME/platform-tools

# for direnv
eval "$(direnv hook zsh)"
# for direnv (virtualenv)
# https://github.com/direnv/direnv/wiki/Python
show_virtual_env() {
  if [ -n "$VIRTUAL_ENV" ]; then
    echo "(venv)"
  fi
}
PS1='$(show_virtual_env)'$PS1

# for dotfiles/bin
PATH=$HOME/.bin:$PATH


# for deno
PATH=$HOME/.deno/bin:$PATH

# for docker
PATH=$HOME/.docker/bin:$PATH

# for cargo
PATH=$HOME/.cargo/bin:$PATH

PATH=$HOME/.local/bin:$PATH

# for postgresql
[ -d /opt/homebrew/opt/libpq ] && PATH=/opt/homebrew/opt/libpq/bin:$PATH


# for Android emulator
function emulatorw { cd "$(dirname $(which emulator))" && ./emulator "$@"; }

# for pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# for go-swagger
alias swagger='docker run --rm -it  --user $(id -u):$(id -g) -e GOPATH=$(go env GOPATH):/go -v $HOME:$HOME -w $(pwd) quay.io/goswagger/swagger'

# for mise
eval "$(mise activate zsh)"
