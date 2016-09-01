#!/bin/sh

cli=/Applications/Karabiner.app/Contents/Library/bin/karabiner

$cli set option.emacsmode_controlLeftbracket 1
/bin/echo -n .
$cli set option.vimode_hjkl 1
/bin/echo -n .
$cli set private.iterm2.ctrl_j_to_kana 1
/bin/echo -n .
$cli set private.vim_keybind_apps_esc_with_eisuu 1
/bin/echo -n .
$cli set remap.space2shiftL_space_fnspace 1
/bin/echo -n .
$cli set repeat.initial_wait 200
/bin/echo -n .
$cli set repeat.wait 20
/bin/echo -n .
/bin/echo
