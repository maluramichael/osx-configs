#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$TOOLS_HOME/dmenu" ]; then
  git clone https://git.suckless.org/dmenu "$TOOLS_HOME/dmenu" --recurse-submodules
fi

cd "$TOOLS_HOME/dmenu" || return
git pull

make
sudo make install
