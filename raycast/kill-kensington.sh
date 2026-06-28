#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Kill KensingtonWorks
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🖱️
# @raycast.packageName System

if pkill -9 -x "KensingtonWorksHelper"; then
  echo "KensingtonWorks を再起動しました"
else
  echo "KensingtonWorks は起動していません"
fi
