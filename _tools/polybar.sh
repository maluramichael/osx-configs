#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$TOOLS_HOME/polybar" ]; then
  git clone git@github.com:polybar/polybar.git "$TOOLS_HOME/polybar"
fi

cd "$TOOLS_HOME/polybar" || return
git pull
git submodule update --init --recursive --remote
mkdir -p build
cd build || return
cmake -DCMAKE_BUILD_TYPE="Release" -DCMAKE_INSTALL_PREFIX="$INSTALL_PREFIX" \
  -DENABLE_ALSA=ON \
  -DENABLE_I3=ON \
  -DENABLE_MPD=ON \
  -DENABLE_NETWORK=ON \
  ..
make
make install
