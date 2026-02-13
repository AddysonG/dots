#!/usr/bin/env bash

set -euo pipefail

WALL_DIR="$HOME/.config/hypr/wallpapers"
TEMP_DIR="$HOME/.config/hypr/temp"

wall="$(
    find -L "$WALL_DIR" -maxdepth 1 -type f \
        \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) \
    | shuf -n1 \
    || true
)"

[[ -n "${wall:-}" ]] || exit 0
hyprctl hyprpaper wallpaper ,"$wall"

ext="${wall##*.}"
mkdir -p "$TEMP_DIR"
ln -sf "$wall" "$TEMP_DIR/current-wallpaper"
