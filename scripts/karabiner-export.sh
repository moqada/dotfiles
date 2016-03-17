#!/usr/bin/env sh
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
ROOT_DIR=`dirname $SCRIPT_DIR`
/Applications/Karabiner.app/Contents/Library/bin/karabiner export > $ROOT_DIR/karabiner-import.sh
