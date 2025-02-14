#!/usr/bin/env sh

BASE_DIR=$(cd $(dirname $(dirname $0)); pwd)

# dotfiles
$BASE_DIR/scripts/setup.sh

# Karabiner Elements
[ -d $HOME/.config/karabiner ] && echo "exist $HOME/.config/karabiner" \
    || ln -s $BASE_DIR/karabiner $HOME/.config/karabiner

# Xcode
xcode-select --install

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
brew bundle --file=$BASE_DIR/Brewfile

# Git (for Homebrew)
CONTRIB_PATH=/opt/homebrew/share/git-core/contrib
chmod +x $CONTRIB_PATH/diff-highlight/diff-highlight
ln -s $CONTRIB_PATH/diff-highlight/diff-highlight /opt/homebrew/bin/diff-highlight
