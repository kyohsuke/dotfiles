#!/usr/bin/env bash

TOOLS=(
  parallel
  ctags
  git
  git-hooks-go
  ghq
  gnupg
  hub
  delta
  libsodium
  mono
  p7zip
  peco
  pstree
  rust
  shellcheck
  skktools
  tldr
  watch
  hivemind
  cmake
  bat
  imagemagick
  ipcalc
  direnv
  git-extras
  terminal-notifier
  go
  aria2
  libpq
)

LIST=""
for TOOL in "${TOOLS[@]}"
do
  LIST="brew \"$TOOL\"\\n$LIST"
done

# Install development tools
echo -e "$LIST" | brew bundle --file=/dev/stdin 

GO_PACKAGES=$(cat .go-package)
for PACKAGE in $GO_PACKAGES; do
  go get "$PACKAGE"
done
