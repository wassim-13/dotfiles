#!/usr/bin/env bash

DIR="$HOME/Pictures/Screenshots"
[[ ! -d "$DIR" ]] && mkdir -p "$DIR"

path="$HOME/Pictures/Screenshots/$(date +'%d%m%y-%H%M%S').png"

if [[ "$1" = "w" ]]; then
    win=$(hyprctl activewindow)
    if [[ "$win" = "Invalid" ]]; then
        region=$(hyprctl monitors -j | jq -r '.[0] | "\(.x),\(.y) \(.width)x\(.height)"')
    else
        region=$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')
    fi
else
    region=$(slurp)
fi

if grim -g "$region" "$path"; then
    ACTION=$(notify-send "ScreenShot" -i "$path" "saved screenshot at : $path" --action="default=Open")
    [[ "$ACTION" = "default" ]] && xdg-open "$path"
fi
