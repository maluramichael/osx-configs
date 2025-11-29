#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$LIBS_HOME/easyloggingpp" ]; then
    git clone git@github.com:amrayn/easyloggingpp.git "$LIBS_HOME/easyloggingpp"
fi

cd "$LIBS_HOME/easyloggingpp" || return
git pull
mkdir -p build
cd build || return
cmake -DCMAKE_BUILD_TYPE="Release" -DCMAKE_INSTALL_PREFIX="$INSTALL_PREFIX" ..
make
make install
