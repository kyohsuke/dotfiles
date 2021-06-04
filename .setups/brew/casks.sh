#!/usr/bin/env bash

CASKS=(
  charles
  firefox
  docker
  keka
)

LIST=""
for CASK in "${CASKS[@]}"
do
  LIST="cask \"$CASK\"\\n$LIST"
done

# Install casks
echo -e "$LIST" | brew bundle --file=/dev/stdin
