#!/usr/bin/env sh

BASE_DIR=$(cd $(dirname $(dirname $0)); pwd)

# dotfiles
$BASE_DIR/scripts/setup.sh

# Xcode
xcode-select --install

# Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
sh $BASE_DIR/Brewfile

# AppStore
$BASE_DIR/scripts/mas-install.sh

# Karabiner
$BASE_DIR/scripts/karabiner-import.sh
ln -s $BASE_DIR/private.xml $HOME/Library/Application\ Support/Karabiner/private.xml

# Git (for Homebrew)
CONTRIB_PATH=/usr/local/share/git-core/contrib
chmod +x $CONTRIB_PATH/diff-highlight/diff-highlight
ln -s $CONTRIB_PATH/diff-highlight/diff-highlight /usr/local/bin/diff-highlight
