#!/usr/bin/env bash

BREWFILE=$(cat << EOS
brew "difftastic"
brew "parallel"
brew "ctags"
brew "git"
brew "git-hooks-go"
brew "ghq"
brew "gnupg"
brew "gh"
brew "libsodium"
brew "p7zip"
brew "peco"
brew "pstree"
brew "rust"
brew "shellcheck"
brew "skktools"
brew "tldr"
brew "watch"
brew "hivemind"
brew "cmake"
brew "bat"
brew "ipcalc"
brew "direnv"
brew "go"
brew "aria2"
brew "libpq"
EOS
)

echo -e "$BREWFILE" | brew bundle --file=/dev/stdin
