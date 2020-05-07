#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$LIBS_HOME/libpng" ]; then
    git clone https://git.code.sf.net/p/libpng/code "$LIBS_HOME/libpng"
fi

cd "$LIBS_HOME/libpng" || return
git pull
./autogen.sh
./configure --prefix="$INSTALL_PREFIX"
make
make install
