#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$LIBS_HOME/SDL_ttf" ]; then
  hg clone https://hg.libsdl.org/SDL_ttf "$LIBS_HOME/SDL_ttf"
fi

cd "$LIBS_HOME/SDL_ttf" || return
hg pull && hg update
./autogen.sh
CC=g++ ./configure --prefix="$INSTALL_PREFIX" \
  --with-sdl-prefix="$INSTALL_PREFIX"
make
make install
