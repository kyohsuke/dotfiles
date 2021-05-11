#!/usr/bin/env bash

if test ! "$(command -v whalebrew)"; then
  if [ "$WORK" != "true" ]; then
    brew install whalebrew

    whalebrew whalebrew/imagemagick
    whalebrew whalebrew/youtube-dl
  fi
fi
