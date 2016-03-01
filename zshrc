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

# for go
# @see: http://akirachiku.com/2016/03/01/go16-development.html
alias gp='cd $GOPATH_WORK/src/github.com/moqada'

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
export HISTSIZE=10000
export SAVEHIST=10000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

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

# for virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
source `which virtualenvwrapper.sh`
# see: http://ymotongpoo.hatenablog.com/entry/20120516/1337123564
mkvenv () {
    base_python=`which python$1`
    mkvirtualenv --distribute --python=$base_python $2
}


# for nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

# for rbenv
export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"

# for phpenv
export PATH=$HOME/.phpenv/bin:$PATH
eval "$(phpenv init -)"

# for homebrew-cask
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# include private settings
ZSHRCLOCAL_PATH=$HOME/.zshrc.local
if [ -f $ZSHRCLOCAL_PATH ]; then
    source $ZSHRCLOCAL_PATH
fi

# for terminal-notifier
source ~/.zsh.d/zsh-notify/notify.plugin.zsh
export GROWL_NOTIFIER=`which growlnotify`

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
GIT_PROMPT_EXECUTABLE="haskell"
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

# for dotfiles/bin
PATH=$HOME/.bin:$PATH
