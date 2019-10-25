#!/usr/bin/env bash

if [ "$SHELL" != "/usr/local/bin/zsh" ]; then
  # Install Zsh
  brew install zsh
  brew install zsh-completions
  echo "Adding the newly installed shell to the list of allowed shells"
  grep -q /usr/local/bin/zsh /etc/shells || sudo bash -c 'echo /usr/local/bin/zsh >> /etc/shells'
  # Change to the new shell, prompts for password
  chsh -s /usr/local/bin/zsh

  if [ -z "$WITHOUT_OH_MY_ZSH" ]; then
    # install oh-my-zsh
    git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh"
  fi

  # fix compaudit for zsh
  chmod g-w,o-w /usr/local/share
fi
