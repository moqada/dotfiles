#!/usr/bin/env sh

BASE_DIR=$(cd $(dirname $(dirname $0)); pwd)

# Git
ln -si $BASE_DIR/gitconfig $HOME/.gitconfig
ln -si $BASE_DIR/gitignore $HOME/.gitignore

# Tig
ln -si $BASE_DIR/tigrc $HOME/.tigrc

# XDG Config
mkdir -p $HOME/.config

# TMUX
[ -d $HOME/.config/tmux ] && echo "exist $HOME/.config/tmux" \
    || (ln -s $BASE_DIR/tmux $HOME/.config/tmux && echo "create $HOME/.config/tmux")
[ -d $HOME/.config/tmux-powerline ] && echo "exist $HOME/.config/tmux-powerline" \
    || (ln -s $BASE_DIR/tmux-powerline $HOME/.config/tmux-powerline && echo "create $HOME/.config/tmux-powerline")

# Ghostty
[ -d $HOME/.config/ghostty ] && echo "exist $HOME/.config/ghostty" \
    || (ln -s $BASE_DIR/ghostty $HOME/.config/ghostty && echo "create $HOME/.config/ghostty")

# Helix
[ -d $HOME/.config/helix ] && echo "exist $HOME/.config/helix" \
    || (ln -s $BASE_DIR/helix $HOME/.config/helix && echo "create $HOME/.config/helix")

# Vim (素 vim 用の最小設定。リモート / sudo vim / Neovim 未導入環境の保険)
ln -si $BASE_DIR/vimrc $HOME/.vimrc
ln -si $BASE_DIR/gvimrc $HOME/.gvimrc

# Neovim (メインエディタ。VimR も中身は Neovim なのでこの設定が適用される)
[ -d $HOME/.config/nvim ] && echo "exist $HOME/.config/nvim" \
    || (ln -s $BASE_DIR/nvim $HOME/.config/nvim && echo "create $HOME/.config/nvim")

# Zsh
ln -si $BASE_DIR/zshrc $HOME/.zshrc
[ -d $HOME/.zsh.d ] && echo "exist $HOME/.zsh.d" \
    || (ln -s $BASE_DIR/zsh.d $HOME/.zsh.d && echo "create $HOME/.zsh.d")

# Peco
[ -d $HOME/.peco ] && echo "exist $HOME/.peco" \
    || (ln -s $BASE_DIR/peco $HOME/.peco && echo "create $HOME/.peco")


# Mackup
ln -si $BASE_DIR/mackup.cfg $HOME/.mackup.cfg

# NPM
ln -si $BASE_DIR/npmrc $HOME/.npmrc

# direnv
ln -si $BASE_DIR/direnvrc $HOME/.direnvrc

# bin
[ -d $HOME/.bin ] && echo "exist $HOME/.bin" \
    || (ln -s $BASE_DIR/bin $HOME/.bin && "create $HOME/.bin")
