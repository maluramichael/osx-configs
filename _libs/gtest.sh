#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$LIBS_HOME/gtest" ]; then
    git clone git@github.com:google/googletest.git "$LIBS_HOME/gtest"
fi

cd "$LIBS_HOME/gtest" || return
git pull
mkdir -p build
cd build || return
cmake -DCMAKE_BUILD_TYPE="Release" -DCMAKE_INSTALL_PREFIX="$INSTALL_PREFIX" ..
make
make install
