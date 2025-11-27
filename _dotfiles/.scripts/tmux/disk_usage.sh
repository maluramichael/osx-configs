#!/bin/bash
# Disk usage for tmux status bar (macOS)

# Get disk usage for main volume
disk_info=$(df -h / 2>/dev/null | tail -1 | awk '{print $5}' | sed 's/%//')
if [ -z "$disk_info" ]; then
    echo ""
    exit 0
fi

disk_used=${disk_info%.*}

# Validate disk_used is numeric
if ! [[ "$disk_used" =~ ^[0-9]+$ ]]; then
    echo ""
    exit 0
fi

# Color based on usage
if [ $disk_used -lt 70 ]; then
    color="#9ece6a"
elif [ $disk_used -lt 90 ]; then
    color="#e0af68"
else
    color="#f7768e"
fi

echo "#[fg=$color]💾${disk_used}%"

