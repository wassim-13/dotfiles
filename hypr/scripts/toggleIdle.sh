#!/usr/bin/env bash

if pgrep hypridle; then
    pkill hypridle
else
    hyprctl dispatch 'hl.dsp.exec_cmd("hypridle")'
fi
