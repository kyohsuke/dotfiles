#!/usr/bin/env bash

if [ "$SHELL" != "/usr/local/bin/fish" ]; then
  # Install Fish
  brew install fish fisher

  fish -C "source /usr/local/share/fish/vendor_functions.d/fisher.fish && fisher update; exit"

  # Install oh-my-fish
  curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
  fish -C "omf update && omf install coffeeandcode && omf theme coffeeandcode"

  # Change to the new shell, prompts for password
  sudo chsh -s /usr/local/bin/fish "$USER"
fi
