#!/usr/bin/env bash

CURRENT_TAPS=$(brew tap)

TAPS=(
  genkiroid/cert
  kyohsuke/misc
  homebrew/cask-fonts
  nektos/tap
)

LIST=""
for TAP in "${TAPS[@]}"
do
  echo "$CURRENT_TAPS" | grep --silent "$TAP" || LIST="$LIST\\ntap \"$TAP\""
done

# Install cert checker
LIST="$LIST\\nbrew \"cert\""

# Install misc files
LIST="$LIST\\ncask \"macface-haruhi\""

# Install act
LIST="$LIST\\nbrew \"nektos/tap/act\""

echo -e "$LIST" | brew bundle --file=/dev/stdin
