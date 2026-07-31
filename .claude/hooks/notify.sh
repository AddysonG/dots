#!/usr/bin/env bash
# Claude Code → macOS Notification Center bridge.
# Wired in ~/.claude/settings.json under hooks.Notification and hooks.Stop.
# Bypasses the terminal entirely so it works under tmux + kitty.
#
# Title is "<idx>:<window> · Claude" inside tmux, "<cwd-basename> · Claude" as
# a fallback, or just "Claude" if neither resolves. Body is "<label> — <detail>"
# when the payload supplies a message, else just "<label>". Leading "(" or "["
# can't be used in either field — terminal-notifier's NSUserDefaults arg parser
# treats them as property-list array/data syntax and silently drops the field.
set -eo pipefail

NOTIFIER="/opt/homebrew/bin/terminal-notifier"
SENDER="com.anthropic.claudefordesktop"

kind="${1:-unknown}"
payload="$(cat)"

case "$kind" in
  permission) label="Claude needs permission"; sound="Glass" ;;
  idle)       label="Claude is idle";          sound="Glass" ;;
  stop)       label="Claude finished";         sound="Pop"   ;;
  *)          label="Claude";                  sound="Glass" ;;
esac

prefix=""
if [[ -n "$TMUX" && -n "$TMUX_PANE" ]]; then
  prefix="$(tmux display-message -t "$TMUX_PANE" -p '#I:#W' 2>/dev/null || true)"
fi
if [[ -z "$prefix" ]]; then
  cwd="$(printf '%s' "$payload" | jq -r '.cwd // empty')"
  prefix="${cwd##*/}"
fi

if [[ -n "$prefix" ]]; then
  title="${prefix} · Claude"
else
  title="Claude"
fi

detail="$(printf '%s' "$payload" | jq -r '.message // empty')"
if [[ -n "$detail" ]]; then
  body="${label} — ${detail}"
else
  body="${label}"
fi

"$NOTIFIER" \
  -title    "$title" \
  -message  "$body" \
  -sender   "$SENDER" \
  -sound    "$sound" \
  >/dev/null 2>&1 || true
