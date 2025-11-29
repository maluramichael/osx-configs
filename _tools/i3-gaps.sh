#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$TOOLS_HOME/i3-gaps" ]; then
  git clone git@github.com:Airblader/i3.git "$TOOLS_HOME/i3-gaps" --recurse-submodules
fi

cd "$TOOLS_HOME/i3-gaps" || return
git pull
mkdir build
autoreconf --force --install
cd build
../configure --prefix="/usr" --sysconfdir=/etc --disable-check --disable-sanitizers --enable-debug=no
make
sudo make install
