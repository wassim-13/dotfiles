#!/usr/bin/env bash

path="$HOME/Pictures/Screenshots/$(date +'%d%m%y-%H%M%S').png"

if grim -g "$(slurp)" "$path"; then
    ACTION=$(notify-send -a "ScreenShot" -i "$path" "saved screenshot at : $path" --action="default=Open")
    [[ "$ACTION" = "default" ]] && xdg-open "$path"
fi
