#!/usr/bin/env bash

if test ! "$(command -v whalebrew)"; then
  if [ "$WORK" != "true" ]; then
    brew install whalebrew

    WHALEBREWS=(
      imagemagick
      ffmpeg
    )

    for WHALEBREW in "${WHALEBREWS[@]}"
    do
      whalebrew "whalebrew/${WHALEBREW}"
    done
  fi
fi
