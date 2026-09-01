#!/usr/bin/env bash

DIR="$HOME/Videos/Records"
[[ ! -d "$DIR" ]] && mkdir -p "$DIR"

path="$HOME/Videos/Records/$(date +'%d%m%y-%H%M%S').mp4"
icon="$HOME/Videos/Records/rec.png"

a=$(pgrep "wl-screenrec" | wc -l)

if ((a > 0)); then
    kill $(pgrep "wl-screenrec")
    exit
fi

if wl-screenrec -g "$(slurp)" --codec hevc --low-power=off -b "15 MB" -f "$path"; then
    ACTION=$(notify-send -i "$icon" "Screen Record" "saved screen record at : $path" --action="default=Open")

    [[ "$ACTION" = "default" ]] && xdg-open "$path"
fi
