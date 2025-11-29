#!/bin/bash
# Battery status for tmux status bar (macOS)

if command -v pmset >/dev/null 2>&1; then
    battery_info=$(pmset -g batt 2>/dev/null | grep -E "([0-9]+)%" | awk '{print $3}' | sed 's/;//g' | sed 's/%//')
    
    if [ -z "$battery_info" ]; then
        # No battery (desktop Mac)
        echo ""
        exit 0
    fi
    
    battery_percent=${battery_info%?}
    battery_status=${battery_info: -1}
    
    # Validate battery percent is numeric
    if ! [[ "$battery_percent" =~ ^[0-9]+$ ]]; then
        echo ""
        exit 0
    fi
    
    # Determine color and icon
    if [ "$battery_status" = "C" ]; then
        icon="⚡"
        color="#9ece6a"
    elif [ $battery_percent -gt 50 ]; then
        icon="🔋"
        color="#9ece6a"
    elif [ $battery_percent -gt 20 ]; then
        icon="🔋"
        color="#e0af68"
    else
        icon="🔋"
        color="#f7768e"
    fi
    
    echo "#[fg=$color]$icon$battery_percent%"
else
    echo ""
fi

