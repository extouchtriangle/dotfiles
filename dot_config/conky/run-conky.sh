#!/usr/bin/env bash
cd ~/.config/conky
if [ "$(hostname)" = evermore ]; then
  conky -c ~/.config/conky/cal2.conf &
fi
