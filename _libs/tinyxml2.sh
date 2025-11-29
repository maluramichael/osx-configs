#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$LIBS_HOME/tinyxml2" ]; then
  git clone git@github.com:leethomason/tinyxml2.git "$LIBS_HOME/tinyxml2"
fi

cd "$LIBS_HOME/tinyxml2" || return
git pull
mkdir -p build
cd build || return
cmake -DCMAKE_BUILD_TYPE="Release" -DCMAKE_INSTALL_PREFIX="$INSTALL_PREFIX" ..
make
make install
