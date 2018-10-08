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

# for gomi
alias gm='gomi'

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

# PROMPT
autoload colors
colors
PROMPT='%{$fg[blue]%}[%~]%{$reset_color%} %b$(git_super_status)
%{$fg[blue]%}\$%{$reset_color%} '

# Key-Binds
# -e = Emacs / -v = Vi
# @see http://journal.mycom.co.jp/cgi-bin/print?id=41896
bindkey -v
setopt autocd

export EDITOR=vim

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

# for nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH=$HOME/.config/yarn/global/node_modules/.bin:$PATH

# for rbenv
export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"

# for homebrew
export PATH=/usr/local/sbin:$PATH
# for homebrew-cask
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# include private settings
ZSHRCLOCAL_PATH=$HOME/.zshrc.local
if [ -f $ZSHRCLOCAL_PATH ]; then
    source $ZSHRCLOCAL_PATH
fi

# for terminal-notifier
source ~/.zsh.d/zsh-notify/notify.plugin.zsh

# for travis gem
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

# for go
GOPATH_ROOT=$HOME/.go
GOPATH_WORK=$HOME/work/projects/go
export GOPATH=$GOPATH_ROOT:$GOPATH_WORK
export PATH=$GOPATH_ROOT/bin:$GOPATH_WORK/bin:$PATH

# for gom
export GO15VENDOREXPERIMENT=1 

# for peco
source ~/.zsh.d/peco.zsh

# for zsh-git-prompt
source ~/.zsh.d/zsh-git-prompt/zshrc.sh
ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[blue]%}%{✚ %G%}"

# for haskell
[ -d /opt/ghc/current ] && export PATH=/opt/ghc/current/bin:$PATH

# for enhancd
# required `ghq get b4b4r07/enhancd`
[ -d ~/work/src/github.com/b4b4r07/enhancd ] && source ~/work/src/github.com/b4b4r07/enhancd/zsh/enhancd.zsh

# for vim
[ -d /opt/vim ] && export PATH=/opt/vim/bin:$PATH

# for google-cloud-sdk
if [ -d /opt/homebrew-cask/Caskroom/google-cloud-sdk/latest ]; then
    source /opt/homebrew-cask/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
    source /opt/homebrew-cask/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
fi

# for dokata
export DOKATA_TEMPLATE_DIR=~/work/projects/moqada

# for gnu-sed on brew
PATH=/usr/local/opt/gnu-sed/libexec/gnubin:$PATH
MANPATH=/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH

# for React Native (Android Studio on Mac)
export ANDROID_HOME=~/Library/Android/sdk
PATH=$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH

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


# for Android emulator
function emulatorw { cd "$(dirname $(which emulator))" && ./emulator "$@"; }

# for pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
