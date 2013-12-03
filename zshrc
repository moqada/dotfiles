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
alias tmux='TERM=xterm-256color tmux'

# for git
alias gi='git'
alias gst='git status -s -b'
alias gch='git cherry -v'
alias glgg='git logg'
alias glg='git logg | head'
alias ggl='git gl'
alias gga='git ga'
alias gd='git diff'
alias gdc='git diff --cached'

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
# @see http://journal.mycom.co.jp/column/zsh/002/
# @see http://www.machu.jp/b/zsh.html
#PROMPT='%(!.#.$)'
#case "$TERM" in
#xterm*|kterm*|rxvt*)
#    # TITLE BAR
#    # @see t-kawadu's .zshrc
#    PROMPT=$(print "%{\e]2;%n@%m: %~\7%}$PROMPT")
#;;
#screen*)
#    # TITLE BAR
#    # @see http://d.hatena.ne.jp/amt/20060530/Screen
#    printf "\033P\033]0;$USER@$HOSTNAME\007\033\\"
#;;
#esac
#RPROMPT="[%~]"
autoload colors
colors
PROMPT="%{${fg[cyan]}%}<%n@%m>%(!.#.$) %{${reset_color}%}"
RPROMPT="[%~]"

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

# for mercurial
function mq() {
  hg qpop -af
  hg $@
  hg qpush -af
}

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

# include private settings
ZSHRCLOCAL_PATH=$HOME/.zshrc.local
if [ -f $ZSHRCLOCAL_PATH ]; then
    source $ZSHRCLOCAL_PATH
fi
