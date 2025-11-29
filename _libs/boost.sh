#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$LIBS_HOME/boost" ]; then
    git clone --recurse-submodules git@github.com:boostorg/boost.git "$LIBS_HOME/boost"
fi

cd "$LIBS_HOME/boost" || return
git pull --recurse-submodules
./bootstrap.sh --prefix="$INSTALL_PREFIX"
./b2 -q -d0 install
