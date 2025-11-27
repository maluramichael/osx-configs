#!/bin/bash
# Quick git branch display for window list (lightweight)

path="$1"
if [ -z "$path" ]; then
    path=$(tmux display-message -p '#{pane_current_path}')
fi

if [ -d "$path/.git" ]; then
    branch=$(cd "$path" && git branch --show-current 2>/dev/null)
    if [ -n "$branch" ]; then
        # Truncate long branch names
        if [ ${#branch} -gt 15 ]; then
            branch="${branch:0:12}..."
        fi
        echo "#[fg=#bb9af7]🌿$branch"
    fi
fi

