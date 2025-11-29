#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$LIBS_HOME/gmp" ]; then
    hg clone https://gmplib.org/repo/gmp "$LIBS_HOME/gmp"
fi

cd "$LIBS_HOME/gmp" || return
hg update && hg pull
./configure --disable-shared --enable-static --prefix="$INSTALL_PREFIX"
make && make check && make install
