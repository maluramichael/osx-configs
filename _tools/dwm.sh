#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$TOOLS_HOME/dwm" ]; then
  git clone https://git.suckless.org/dwm "$TOOLS_HOME/dwm" --recurse-submodules
fi

cd "$TOOLS_HOME/dwm" || return
git pull
