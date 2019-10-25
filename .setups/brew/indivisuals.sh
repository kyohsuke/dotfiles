#!/usr/bin/env bash

# check and install homebrew
if [ "$WORK" != "true" ]; then
  CASKS=(
    dropbox
    xld
    cooviewer
    kindle
    timemachineeditor
  )

  LIST=""
  for CASK in "${CASKS[@]}"
  do
    LIST="cask \"$CASK\"\\n$LIST"
  done

  echo -e "$LIST" | brew bundle --file=/dev/stdin 
fi
