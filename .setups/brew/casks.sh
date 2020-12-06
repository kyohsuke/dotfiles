#!/usr/bin/env bash

CASKS=(
  charles
  firefox
  bitbar
  psequel
  docker
  qlcolorcode
  qlstephen
  qlprettypatch
)

LIST=""
for CASK in "${CASKS[@]}"
do
  LIST="cask \"$CASK\"\\n$LIST"
done

# Install casks
echo -e "$LIST" | brew bundle --file=/dev/stdin
