#!/usr/bin/env bash

BREWFILE=$(cat << EOS
cask "charles"
cask "firefox"
cask "docker"
cask "keka"
EOS
)

# Install casks
echo -e "$BREWFILE" | brew bundle --file=/dev/stdin
