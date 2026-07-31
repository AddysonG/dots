# Reading a scraped Claude Code statusline

When you read a Claude Code statusline from a pane other than your own (`herdr agent read`,
tmux capture, a screenshot), parse it left to right as:

`󰘬 <branch>   ctx:<N>% <bar>  󰚩 <model> (<effort>)`

- `<branch>` — git branch of that session's directory. Absent entirely outside a repo.
- `ctx:<N>%` — context **used**, not remaining. `ctx:9%` = 9% consumed, ~91% free.
- `<model>` — model name, with reasoning effort in trailing parens when the model has one.

**Staleness:** a statusline is a repaint from that pane's last render, not a live reading.
An idle pane can show arbitrarily old values, for every field. Never compare values across
panes as if sampled at the same moment; only a new assistant message forces a fresh render.
