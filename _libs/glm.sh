#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$LIBS_HOME/glm" ]; then
  git clone git@github.com:g-truc/glm.git "$LIBS_HOME/glm"
fi

cd "$LIBS_HOME/glm" || return
git pull
mkdir -p build
cd build || return
cmake -DCMAKE_BUILD_TYPE="Release" -DCMAKE_INSTALL_PREFIX="$INSTALL_PREFIX" ..
make
make install
