#!/usr/bin/env bash

if ! [ -d "$HOME/Library/Application Support/AquaSKK" ]; then
  # Install AquaSKK
  echo -e "cask aquaskk" | brew bundle --file=/dev/stdin

  # Set direct writes to AquaSKK
  DIRECT_WRITE_APPS=(com.apple.Terminal org.vim.MacVim com.apple.Spotlight)
  for APP in "${DIRECT_WRITE_APPS[@]}"
  do
    defaults read jp.sourceforge.inputmethod.aquaskk direct_clients | grep -q "$APP" \
      || defaults write jp.sourceforge.inputmethod.aquaskk direct_clients -array-add "$APP"
  done

  # Set rules on AquaSKK
  bash "$HOME/skkdic/install.sh"
fi
