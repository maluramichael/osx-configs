#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$LIBS_HOME/pixman" ]; then
    git clone git://anongit.freedesktop.org/git/pixman "$LIBS_HOME/pixman"
fi

cd "$LIBS_HOME/pixman" || return
git pull
./autogen.sh
./configure --prefix="$INSTALL_PREFIX"
make
make install
