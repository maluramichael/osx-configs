#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$LIBS_HOME/SDL_mixer" ]; then
    hg clone https://hg.libsdl.org/SDL_mixer "$LIBS_HOME/SDL_mixer"
fi

cd "$LIBS_HOME/SDL_mixer" || return
hg pull && hg update
./configure --prefix="$INSTALL_PREFIX"
make
make install
