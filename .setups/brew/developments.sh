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
brew "libyaml"
brew "p7zip"
brew "peco"
brew "pstree"
brew "rustup-init"
brew "shellcheck"
brew "skktools"
brew "watch"
brew "cmake"
brew "bat"
brew "ipcalc"
brew "direnv"
brew "libpq"
brew "lua"
EOS
)

echo -e "$BREWFILE" | brew bundle --file=/dev/stdin
