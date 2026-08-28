#!/usr/bin/env bash

path="/home/wassim/Pictures/Screenshots/$(date +'%d%m%y-%H%M%S').png"

if grim -g "$(slurp)" "$path"; then
    notify-send -i "$path" "saved screenshot at : $path"
fi
