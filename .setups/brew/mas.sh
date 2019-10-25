#!/usr/bin/env bash

if test ! "$(command -v mas)"; then
  brew install mas

  # install applications from App Store
  mas install 412485838  --force # Witch
  mas install 1298486723 --force # FileZilla Pro
  mas install 497799835  --force # Xcode
  mas install 425955336  --force # Skitch
  mas install 478867587  --force # FreeSpace Tab
  mas install 425424353  --force # The Unarchiver

  # Indivisual
  if [ "$WORK" != "true" ]; then
    mas install 430255202  --force # Mactracker
    mas install 407066957  --force # iVolume
    mas install 409203825  --force # Numbers
  else
    mas install 803453959  --force # Slack
  fi
fi
