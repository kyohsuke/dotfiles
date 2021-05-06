#!/usr/bin/env bash

if [ "$SHELL" != "/usr/local/bin/zsh" ]; then
  # Install Zsh
  brew install zsh
  brew install zsh-completions

  # Change to the new shell, prompts for password
  sudo chsh -s /usr/local/bin/zsh "$USER"

  if [ -z "$WITHOUT_OH_MY_ZSH" ]; then
    # install oh-my-zsh
    git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh"
  fi

  # fix compaudit for zsh
  chmod g-w,o-w /usr/local/share
fi
