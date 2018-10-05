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
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew bundle --file=$BASE_DIR/Brewfile

# Git (for Homebrew)
CONTRIB_PATH=/usr/local/share/git-core/contrib
chmod +x $CONTRIB_PATH/diff-highlight/diff-highlight
ln -s $CONTRIB_PATH/diff-highlight/diff-highlight /usr/local/bin/diff-highlight
