#!/usr/bin/env sh

BASE_DIR=$(cd $(dirname $(dirname $0)); pwd)

# dotfiles
$BASE_DIR/scripts/setup.sh

# Karabiner Elements
mkdir -p $HOME/.config
ln -s $BASE_DIR/karabiner $HOME/.config/karabiner

# Xcode
xcode-select --install

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew bundle --file=$BASE_DIR/Brewfile

# install Ricty font
$BASE_DIR/scripts/install-ricty.sh

# Git (for Homebrew)
CONTRIB_PATH=/opt/homebrew/share/git-core/contrib
chmod +x $CONTRIB_PATH/diff-highlight/diff-highlight
ln -s $CONTRIB_PATH/diff-highlight/diff-highlight /opt/homebrew/bin/diff-highlight
