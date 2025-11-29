#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$LIBS_HOME/SDL_image" ]; then
    hg clone https://hg.libsdl.org/SDL_image "$LIBS_HOME/SDL_image"
fi

cd "$LIBS_HOME/SDL_image" || return
hg pull && hg update
./configure --prefix="$INSTALL_PREFIX"
make
make install
