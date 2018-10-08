#!/usr/bin/env sh

brew tap sanemat/font
rew install ricty --with-powerline
cp -f /usr/local/opt/ricty/share/fonts/Ricty*.ttf ~/Library/Fonts/
fc-cache -vf
