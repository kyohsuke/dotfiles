#!/usr/bin/env bash

if [ "$WITH_MAS" != "false" ]; then
  if test ! "$(command -v mas)"; then
    brew install mas

    # install applications from App Store
    mas install 497799835 --force  # Xcode
    mas install 425424353 --force  # The Unarchiver
    mas install 6446431862 --force # EmptyStorage

    # Indivisual
    if [ "$WORK" != "true" ]; then
      mas install 1187772509 --force # stts
      mas install 450664466 --force  # NAS Navigator2
      mas install 407066957 --force  # iVolume
      mas install 430255202 --force  # Mactracker
      mas install 539883307 --force  # LINE
      mas install 409203825 --force  # Numbers
      mas install 1289583905 --force # Pixelmator Pro
      mas install 302584613 --force  # Kindle
    fi
  fi
fi
