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
ln -sfn $BASE_DIR/tmux $HOME/.config/tmux
ln -sfn $BASE_DIR/tmux-powerline $HOME/.config/tmux-powerline

# Ghostty
ln -sfn $BASE_DIR/ghostty $HOME/.config/ghostty

# Helix
ln -sfn $BASE_DIR/helix $HOME/.config/helix

# Vim (素 vim 用の最小設定。リモート / sudo vim / Neovim 未導入環境の保険)
ln -si $BASE_DIR/vimrc $HOME/.vimrc
ln -si $BASE_DIR/gvimrc $HOME/.gvimrc

# Neovim (メインエディタ。VimR も中身は Neovim なのでこの設定が適用される)
ln -sfn $BASE_DIR/nvim $HOME/.config/nvim

# Zsh
ln -si $BASE_DIR/zshrc $HOME/.zshrc
ln -sfn $BASE_DIR/zsh.d $HOME/.zsh.d

# Peco
ln -sfn $BASE_DIR/peco $HOME/.peco

# Mackup
ln -si $BASE_DIR/mackup.cfg $HOME/.mackup.cfg

# NPM
ln -si $BASE_DIR/npmrc $HOME/.npmrc

# direnv
ln -si $BASE_DIR/direnvrc $HOME/.direnvrc

# bin
ln -sfn $BASE_DIR/bin $HOME/.bin

# Codex: share Claude skills
mkdir -p "$HOME/.agents"
ln -sfn "$HOME/.claude/skills" "$HOME/.agents/skills"
