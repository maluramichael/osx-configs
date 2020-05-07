#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$TOOLS_HOME/herbstluftwm" ]; then
  git clone https://github.com/herbstluftwm/herbstluftwm "$TOOLS_HOME/herbstluftwm" --recurse-submodules
fi

cd "$TOOLS_HOME/herbstluftwm" || return
git pull
mkdir -p build
cd build || return
cmake ..
make
sudo make install
