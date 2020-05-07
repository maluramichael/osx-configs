#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$LIBS_HOME/flann" ]; then
  git clone git@github.com:mariusmuja/flann.git "$LIBS_HOME/flann"
fi

cd "$LIBS_HOME/flann" || return
git pull
mkdir -p build
cd build || return
cmake -DCMAKE_BUILD_TYPE="Release" -DCMAKE_INSTALL_PREFIX="$INSTALL_PREFIX" ..
make
make install
