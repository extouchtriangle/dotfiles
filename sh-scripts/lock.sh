#!/usr/bin/env bash
# getting locked out in US keyboard is the worst
bash "$HOME/dotfiles/sh-scripts/keymaps.sh"
if pacman -Q --quiet betterlockscreen; then
  betterlockscreen -l -- -p default
else
  i3lock \
    --beep \
    --ignore-empty-password \
    --show-failed-attempts \
    --nofork \
    --color=d33529 \
    --pointer=win
fi
