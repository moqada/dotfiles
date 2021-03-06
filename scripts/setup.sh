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
[ -d $HOME/.vim ] && echo "exist $HOME/.vim" \
    || (ln -s $BASE_DIR/vim $HOME/.vim && echo "create $HOME/.vim")
ln -si $BASE_DIR/gvimrc $HOME/.gvimrc
[ -d $HOME/.config/nvim ] && echo "exist $HOME/.config/nvim" \
    || (ln -s $HOME/.vim $HOME/.config/nvim && echo "create $HOME/.config/nvim")
ln -si $HOME/.vimrc $HOME/.config/nvim/init.vim

# Zsh
ln -si $BASE_DIR/zshrc $HOME/.zshrc
[ -d $HOME/.zsh.d ] && echo "exist $HOME/.zsh.d" \
    || (ln -s $BASE_DIR/zsh.d $HOME/.zsh.d && echo "create $HOME/.zsh.d")

# Peco
[ -d $HOME/.peco ] && echo "exist $HOME/.peco" \
    || (ln -s $BASE_DIR/peco $HOME/.peco && echo "create $HOME/.peco")


# CoffeeScript
ln -si $BASE_DIR/coffeelint.json $HOME/coffeelint.json

# ESLint
ln -si $BASE_DIR/eslintrc $HOME/.eslintrc

# Mackup
ln -si $BASE_DIR/mackup.cfg $HOME/.mackup.cfg

# NPM
ln -si $BASE_DIR/npmrc $HOME/.npmrc

# cVim
ln -si $BASE_DIR/cvimrc $HOME/.cvimrc

# bin
[ -d $HOME/.bin ] && echo "exist $HOME/.bin" \
    || (ln -s $BASE_DIR/bin $HOME/.bin && "create $HOME/.bin")
