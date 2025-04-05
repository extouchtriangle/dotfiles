#!/usr/bin/env bash

notify-send "i3: exec mode" -i "categories/applications-utilities-symbolic" \
  -t 4000 \
  -u low \
  "
<b>+</b>: increase             <b>-</b>: decrease
<b>0</b>: mute
<b>Space</b>: loginctl lock
"
