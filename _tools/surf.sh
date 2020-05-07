#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$TOOLS_HOME/surf" ]; then
  git clone https://git.suckless.org/surf "$TOOLS_HOME/surf" --recurse-submodules
fi

cd "$TOOLS_HOME/surf" || return
git pull

make
sudo make install
