#!/usr/bin/env bash
AQUASKK_DIR="$HOME/Library/Application Support/AquaSKK/"
RULES=(question.rule sub-rule.desc)

mkdir -p "$AQUASKK_DIR"
for RULE in "${RULES[@]}"
do
  cp -f "$HOME/skkdic/$RULE" "$AQUASKK_DIR"
done
