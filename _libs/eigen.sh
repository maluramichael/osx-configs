#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$LIBS_HOME/eigen" ]; then
    git clone https://gitlab.com/libeigen/eigen.git "$LIBS_HOME/eigen"
fi

cd "$LIBS_HOME/eigen" || return
git pull
mkdir -p build
cd build || return
cmake -DCMAKE_BUILD_TYPE="Release" -DCMAKE_INSTALL_PREFIX="$INSTALL_PREFIX" ..
make
make install
