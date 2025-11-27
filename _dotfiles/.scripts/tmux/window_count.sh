#!/bin/bash
# Window and pane count for tmux status bar

# Check if tmux is available and we're in a session
if ! command -v tmux >/dev/null 2>&1; then
    echo ""
    exit 0
fi

window_count=$(tmux list-windows 2>/dev/null | wc -l | tr -d ' ')
pane_count=$(tmux list-panes 2>/dev/null | wc -l | tr -d ' ')

# Validate counts are numeric
if [ -n "$window_count" ] && [ -n "$pane_count" ] && [[ "$window_count" =~ ^[0-9]+$ ]] && [[ "$pane_count" =~ ^[0-9]+$ ]]; then
    echo "#[fg=#bb9af7]🪟$window_count#[fg=#565f89]/#[fg=#7dcfff]📑$pane_count"
else
    echo ""
fi

