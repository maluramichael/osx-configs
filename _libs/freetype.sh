#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$LIBS_HOME/freetype" ]; then
    git clone git://git.sv.nongnu.org/freetype/freetype2.git "$LIBS_HOME/freetype"
fi

cd "$LIBS_HOME/freetype" || return
git pull
./autogen.sh
./configure --prefix="$INSTALL_PREFIX"
make
make install
