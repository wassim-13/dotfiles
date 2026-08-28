#!/usr/bin/env bash

if pgrep hypridle; then
    pkill hypridle
else
    hypridle &
fi
