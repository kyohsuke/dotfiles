#!/usr/bin/env bash

BREWFILE=$(cat << EOS
brew "difftastic"
brew "parallel"
brew "ctags"
brew "git"
brew "git-hooks-go"
brew "ghq"
brew "gmp"
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
brew "coreutils"
brew "cmake"
brew "cmake-docs"
brew "bat"
brew "ipcalc"
brew "direnv"
brew "libpq"
brew "lua"
brew "readline"
brew "openssl"
cask "homebrew/cask-fonts/font-cica"
cask "gpg-suite-no-mail"
EOS
)

echo -e "$BREWFILE" | brew bundle --file=/dev/stdin
