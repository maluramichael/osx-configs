#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$LIBS_HOME/opencv" ]; then
    git clone git@github.com:opencv/opencv.git "$LIBS_HOME/opencv"
fi

cd "$LIBS_HOME/opencv" || return
git pull
mkdir -p build
cd build || return
cmake -DCMAKE_BUILD_TYPE="Release" -DCMAKE_INSTALL_PREFIX="$INSTALL_PREFIX" ..
make
make install
