#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$TOOLS_HOME/gcc" ]; then
    git clone git://gcc.gnu.org/git/gcc.git "$TOOLS_HOME/gcc"
fi

cd "$TOOLS_HOME/gcc" || return
git pull
./bootstrap --prefix="$INSTALL_PREFIX"
./configure
make
make install
