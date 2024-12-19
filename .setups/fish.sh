#!/usr/bin/env bash

FISH_PATH="$(command -v fish)"
if [ "$SHELL" != "$FISH_PATH" ]; then
  # Install Fish
  brew install fish fisher

  fish -C "source $HOMEBREW_PREFIX/share/fish/vendor_functions.d/fisher.fish && fisher update; exit"

  # Install oh-my-fish
  curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
  fish -C "omf update && omf install coffeeandcode && omf theme coffeeandcode"

  # Change to the new shell, prompts for password
  echo "$FISH_PATH" >>/etc/shells
  sudo chsh -s "$FISH_PATH" "$USER"
fi
