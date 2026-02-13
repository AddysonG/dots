#!/bin/bash
set -euo pipefail

DEVICE_NAME="snsl002d:00-2c2f:002d-touchpad"
STATE_FILE="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/touchpad.enabled"

if [ -f "$STATE_FILE" ]; then
  hyprctl -r -- keyword "device[$DEVICE_NAME]:enabled" true >/dev/null
  rm -f "$STATE_FILE"
else
  hyprctl -r -- keyword "device[$DEVICE_NAME]:enabled" false >/dev/null
  : > "$STATE_FILE"
fi


# Per-session state file (prevents desync after Hyprland restart)
SIG="${HYPRLAND_INSTANCE_SIGNATURE:-nosig}"
RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
STATE_FILE="$RUNTIME_DIR/hypr-touchpad.${SIG}.state"

notify() {
  notify-send -a "Hyprland" -u low "Touchpad" "$1"
}

# Default if unknown: assume enabled, so first toggle disables it
STATE="enabled"
if [[ -f "$STATE_FILE" ]]; then
  STATE="$(<"$STATE_FILE")"
fi

if [[ "$STATE" == "enabled" ]]; then
  hyprctl keyword "device[$DEVICE_NAME]:enabled" false >/dev/null
  echo "disabled" > "$STATE_FILE"
  notify "Disabled"
else
  hyprctl keyword "device[$DEVICE_NAME]:enabled" true >/dev/null
  echo "enabled" > "$STATE_FILE"
  notify "Enabled"
fi
