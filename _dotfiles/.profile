#!/usr/bin/env bash

addToPATH "$HOME/.local/bin"
export _JAVA_AWT_WM_NONREPARENTING=1

echo "$(uname -a) $(uptime -p)"
df -hT -xtmpfs -xvfat -xdevtmpfs
ip addr | grep "inet\\b" | awk '{print $2}' | cut -d/ -f1
