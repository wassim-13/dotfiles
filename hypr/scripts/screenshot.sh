#!/usr/bin/env bash

DIR="$HOME/Pictures/Screenshots"
[[ ! -d "$DIR" ]] && mkdir -p "$DIR"

path="$HOME/Pictures/Screenshots/$(date +'%d%m%y-%H%M%S').png"

if grim -g "$(slurp)" "$path"; then
    ACTION=$(notify-send -a "ScreenShot" -i "$path" "saved screenshot at : $path" --action="default=Open")
    [[ "$ACTION" = "default" ]] && xdg-open "$path"
fi
