#!/usr/bin/env bash

TOOLS=(
  parallel
  ctags
  git
  git-hooks-go
  ghq
  gnupg
  hub
  icdiff
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
  ipcalc
  direnv
  git-extras
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
  go install "$PACKAGE"
done
