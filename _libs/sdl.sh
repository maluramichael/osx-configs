#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$LIBS_HOME/SDL" ]; then
    hg clone https://hg.libsdl.org/SDL "$LIBS_HOME/SDL"
fi

cd "$LIBS_HOME/SDL" || return
hg pull && hg update
./configure --prefix="$INSTALL_PREFIX"
make
make install
