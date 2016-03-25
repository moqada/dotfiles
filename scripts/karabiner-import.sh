#!/bin/sh

cli=/Applications/Karabiner.app/Contents/Library/bin/karabiner

$cli set remap.space2shiftL_space_fnspace 1
/bin/echo -n .
$cli set repeat.wait 30
/bin/echo -n .
$cli set repeat.initial_wait 150
/bin/echo -n .
$cli set option.emacsmode_controlLeftbracket 1
/bin/echo -n .
$cli set option.vimode_hjkl 1
/bin/echo -n .
/bin/echo
