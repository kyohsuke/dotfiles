#!/usr/bin/env bash

BREWFILE=$(cat << EOS
tap "kyohsuke/misc"
tap "homebrew/cask-fonts"
tap "nektos/tap"
tap "genkiroid/cert"

brew "kyohsuke/misc/files"
brew "nektos/tap/act"
brew "genkiroid/cert/cert"
cask "macface-haruhi"
EOS
)

echo -e "$BREWFILE" | brew bundle --file=/dev/stdin
