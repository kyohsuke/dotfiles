#!/usr/bin/env bash

CASKS=(
  charles
  franz
  firefox
  bitbar
  psequel
  docker
  qlcolorcode
  qlstephen
  quicklook-json
  qlprettypatch
  quicklook-csv
  webpquicklook
)

LIST=""
for CASK in "${CASKS[@]}"
do
  LIST="cask \"$CASK\"\\n$LIST"
done

# Install casks
echo -e "$LIST" | brew bundle --file=/dev/stdin
