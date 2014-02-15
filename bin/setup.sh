#!/usr/bin/env sh

BASE_DIR=$(cd $(dirname $(dirname $0)); pwd)

# Git
ln -si $BASE_DIR/gitconfig $HOME/.gitconfig
ln -si $BASE_DIR/gitignore $HOME/.gitignore

# Mercurial
ln -si $BASE_DIR/hgrc $HOME/.hgrc

# TMUX
ln -si $BASE_DIR/tmux.conf $HOME/.tmux.conf

# Vim
ln -si $BASE_DIR/vimrc $HOME/.vimrc
ln -si $BASE_DIR/vim $HOME/.vim
ln -si $BASE_DIR/gvimrc $HOME/.gvimrc

# Zsh
ln -s $BASE_DIR/zshrc $HOME/.zshrc
ln -s $BASE_DIR/zsh.d $HOME/.zsh.d
