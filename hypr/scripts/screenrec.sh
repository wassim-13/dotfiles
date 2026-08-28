#!/usr/bin/env bash

path="/home/wassim/Videos/Records/$(date +'%d%m%y-%H%M%S').mp4"
icon="/home/wassim/Videos/Records/rec.png"

a=$(pgrep "wl-screenrec" | wc -l)

if ((a > 0)); then
    kill $(pgrep "wl-screenrec")
    exit
fi

if wl-screenrec -g "$(slurp)" --codec hevc --low-power=off -b "15 MB" -f "$path"; then
    notify-send -i "$icon" "saved screen record at : $path"
fi
