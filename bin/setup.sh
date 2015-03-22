#!/usr/bin/env sh

BASE_DIR=$(cd $(dirname $(dirname $0)); pwd)

# Git
ln -si $BASE_DIR/gitconfig $HOME/.gitconfig
ln -si $BASE_DIR/gitignore $HOME/.gitignore

# Mercurial
ln -si $BASE_DIR/hgrc $HOME/.hgrc

# Tig
ln -si $BASE_DIR/tigrc $HOME/.tigrc

# TMUX
ln -si $BASE_DIR/tmux.conf $HOME/.tmux.conf

# Vim
ln -si $BASE_DIR/vimrc $HOME/.vimrc
ln -si $BASE_DIR/vim $HOME/.vim
ln -si $BASE_DIR/gvimrc $HOME/.gvimrc

# Zsh
ln -s $BASE_DIR/zshrc $HOME/.zshrc
ln -s $BASE_DIR/zsh.d $HOME/.zsh.d

# Peco
ln -s $BASE_DIR/peco $HOME/.peco
