#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$TOOLS_HOME/bsnes" ]; then
  git clone git@github.com:byuu/bsnes.git "$TOOLS_HOME/bsnes" --recurse-submodules
fi

cd "$TOOLS_HOME/bsnes" || return
git pull
