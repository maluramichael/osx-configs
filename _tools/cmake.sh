#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$TOOLS_HOME/cmake" ]; then
  git clone git@gitlab.kitware.com:cmake/cmake.git "$TOOLS_HOME/cmake"
fi

cd "$TOOLS_HOME/cmake" || return
git pull
./bootstrap --prefix="$INSTALL_PREFIX" --parallel=8
./configure
make
make install
