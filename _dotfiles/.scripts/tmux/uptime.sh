#!/bin/bash
# Session uptime for tmux status bar

# Check if tmux is available
if ! command -v tmux >/dev/null 2>&1; then
    echo ""
    exit 0
fi

# Try to get session creation time from tmux
session_start=$(tmux display-message -p '#{session_created}' 2>/dev/null)
if [ -n "$session_start" ] && [ "$session_start" != "0" ] && [[ "$session_start" =~ ^[0-9]+$ ]]; then
    current_time=$(date +%s 2>/dev/null)
    if [ -n "$current_time" ] && [[ "$current_time" =~ ^[0-9]+$ ]]; then
        uptime_seconds=$((current_time - session_start))
        
        # Handle negative values (shouldn't happen, but be safe)
        if [ $uptime_seconds -lt 0 ]; then
            echo ""
            exit 0
        fi
        
        if [ $uptime_seconds -lt 3600 ]; then
            uptime_display="${uptime_seconds}s"
        elif [ $uptime_seconds -lt 86400 ]; then
            uptime_hours=$((uptime_seconds / 3600))
            uptime_mins=$(((uptime_seconds % 3600) / 60))
            uptime_display="${uptime_hours}h${uptime_mins}m"
        else
            uptime_days=$((uptime_seconds / 86400))
            uptime_hours=$(((uptime_seconds % 86400) / 3600))
            uptime_display="${uptime_days}d${uptime_hours}h"
        fi
        
        echo "#[fg=#7dcfff]⏱ $uptime_display"
    else
        echo ""
    fi
else
    echo ""
fi

