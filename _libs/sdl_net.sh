#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$LIBS_HOME/SDL_net" ]; then
    hg clone https://hg.libsdl.org/SDL_net "$LIBS_HOME/SDL_net"
fi

cd "$LIBS_HOME/SDL_net" || return
hg pull && hg update
./configure --prefix="$INSTALL_PREFIX"
make
make install
