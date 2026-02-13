#!/usr/bin/env bash

if pidof hyprlock; then
    exit 0
fi

source "$HOME/.config/hypr/scripts/random-wall.sh"
sleep 0.1
hyprlock
