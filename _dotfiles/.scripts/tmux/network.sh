#!/bin/bash
# Network activity indicator for tmux status bar (macOS)

# Get network interface (usually en0 for WiFi or en1 for Ethernet)
interface=$(route get default 2>/dev/null | grep interface | awk '{print $2}')

if [ -z "$interface" ]; then
    echo ""
    exit 0
fi

# Get bytes in/out (simplified - shows if there's activity)
bytes_in=$(netstat -ib | grep "$interface" | awk '{print $7}' | head -1)
bytes_out=$(netstat -ib | grep "$interface" | awk '{print $10}' | head -1)

# Simple activity indicator (just shows if network is active)
if [ -n "$bytes_in" ] && [ "$bytes_in" != "0" ]; then
    echo "#[fg=#9ece6a]🌐"
else
    echo "#[fg=#565f89]🌐"
fi

