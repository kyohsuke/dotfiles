#!/usr/bin/env bash

BREWFILE=$(
  cat <<EOS
cask "xld"
cask "cooviewer"
cask "parallels"
EOS
)

# check and install homebrew
if [ "$WORK" != "true" ]; then
  echo -e "$BREWFILE" | brew bundle --file=/dev/stdin
fi
