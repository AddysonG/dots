#!/usr/bin/env bash

if pidof hyprlock; then
    exit 0
fi

hyprlock
