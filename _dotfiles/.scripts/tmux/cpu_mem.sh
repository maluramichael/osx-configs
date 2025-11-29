#!/bin/bash
# CPU and Memory usage for tmux status bar (macOS)

# Get CPU usage (average of all cores)
cpu_usage=$(top -l 1 -n 0 2>/dev/null | grep "CPU usage" | awk '{print $3}' | sed 's/%//')
if [ -z "$cpu_usage" ]; then
    echo ""
    exit 0
fi

# Extract integer part of CPU usage
cpu_int=${cpu_usage%.*}
# Handle empty or invalid values
if [ -z "$cpu_int" ] || ! [[ "$cpu_int" =~ ^[0-9]+$ ]]; then
    cpu_int=0
fi

# Get memory usage using vm_stat
page_size=$(vm_stat | grep "page size" | awk '{print $8}' | tr -d '.')
if [ -z "$page_size" ] || [ "$page_size" = "0" ]; then
    echo "#[fg=#7aa2f7]CPU:$cpu_int%"
    exit 0
fi

# Calculate memory stats (remove dots and commas from numbers)
free_pages=$(vm_stat | grep "Pages free" | awk '{print $3}' | tr -d '.,')
active_pages=$(vm_stat | grep "Pages active" | awk '{print $3}' | tr -d '.,')
inactive_pages=$(vm_stat | grep "Pages inactive" | awk '{print $3}' | tr -d '.,')
wired_pages=$(vm_stat | grep "Pages wired down" | awk '{print $4}' | tr -d '.,')

# Convert pages to MB (handle empty values)
free_pages=${free_pages:-0}
active_pages=${active_pages:-0}
inactive_pages=${inactive_pages:-0}
wired_pages=${wired_pages:-0}

# Convert pages to MB
free_mb=$((free_pages * page_size / 1048576))
active_mb=$((active_pages * page_size / 1048576))
inactive_mb=$((inactive_pages * page_size / 1048576))
wired_mb=$((wired_pages * page_size / 1048576))

mem_used=$((active_mb + wired_mb))
mem_total=$((free_mb + active_mb + inactive_mb + wired_mb))

if [ $mem_total -gt 0 ]; then
    mem_percent=$((mem_used * 100 / mem_total))
else
    mem_percent=0
fi

# Color based on usage
if [ $cpu_int -lt 50 ]; then
    cpu_color="#9ece6a"
elif [ $cpu_int -lt 80 ]; then
    cpu_color="#e0af68"
else
    cpu_color="#f7768e"
fi

if [ $mem_percent -lt 50 ]; then
    mem_color="#9ece6a"
elif [ $mem_percent -lt 80 ]; then
    mem_color="#e0af68"
else
    mem_color="#f7768e"
fi

echo "#[fg=$cpu_color]CPU:$cpu_int%#[fg=#565f89] #[fg=$mem_color]MEM:$mem_percent%"

