#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$TOOLS_HOME/bspwm" ]; then
  git clone git@github.com:baskerville/bspwm.git "$TOOLS_HOME/bspwm" --recurse-submodules
fi

cd "$TOOLS_HOME/bspwm" || return
git pull
