#!/usr/bin/env bash
cd ~/.config/conky
if [ "$(hostname)" = ArchEmerald ]; then
  conky -c ~/.config/conky/summary-bar-1920x1080-onescreen.conf &
fi
