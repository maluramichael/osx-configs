#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$TOOLS_HOME/akira" ]; then
  git clone git@github.com:akiraux/Akira.git "$TOOLS_HOME/akira"
fi

cd "$TOOLS_HOME/akira" || return
git pull

meson build --prefix="$INSTALL_PREFIX" -Dprofile=default
cd build
ninja && ninja install
