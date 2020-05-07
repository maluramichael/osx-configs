#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$LIBS_HOME/cairo" ]; then
    git clone git://anongit.freedesktop.org/git/cairo "$LIBS_HOME/cairo"
fi

cd "$LIBS_HOME/cairo" || return
git pull
./autogen.sh
./configure --prefix="$INSTALL_PREFIX"
make
make install
