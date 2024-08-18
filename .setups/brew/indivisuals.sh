#!/usr/bin/env bash

# check and install homebrew
if [ "$WORK" != "true" ]; then
  BREWFILE=$(
    cat <<EOS
cask "xld"
cask "cooviewer"
cask "kindle"
cask "timemachineeditor"
EOS
  )

  echo -e "$BREWFILE" | brew bundle --file=/dev/stdin
fi
