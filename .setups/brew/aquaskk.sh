#!/usr/bin/env bash

if ! [ -d "$HOME/Library/Application Support/AquaSKK" ]; then
  # Install AquaSKK
  brew cask install aquaskk

  # Set direct writes to AquaSKK
  DIRECT_WRITE_APPS=(com.apple.Terminal org.vim.MacVim com.apple.Spotlight)
  for APP in "${DIRECT_WRITE_APPS[@]}"
  do
    defaults read jp.sourceforge.inputmethod.aquaskk direct_clients | grep -q "$APP" \
      || defaults write jp.sourceforge.inputmethod.aquaskk direct_clients -array-add "$APP"
  done

  # Set rules on AquaSKK
  mkdir -p ~/Library/Application\ Support/AquaSKK/
  cp -f ~/skkdic/question.rule ~/Library/Application\ Support/AquaSKK/
  cp -f ~/skkdic/sub-rule.desc ~/Library/Application\ Support/AquaSKK/
fi
