#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$LIBS_HOME/entityx" ]; then
  git clone git@github.com:alecthomas/entityx.git "$LIBS_HOME/entityx"
fi

cd "$LIBS_HOME/entityx" || return
git pull
mkdir -p build
cd build || return
cmake -DCMAKE_BUILD_TYPE="Release" -DCMAKE_INSTALL_PREFIX="$INSTALL_PREFIX" ..
make
make install
