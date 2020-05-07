#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$LIBS_HOME/mpc" ]; then
    git clone https://scm.gforge.inria.fr/anonscm/git/mpc/mpc.git "$LIBS_HOME/mpc"
fi

cd "$LIBS_HOME/mpc" || return
git pull
./configure --disable-shared --enable-static --prefix="$INSTALL_PREFIX" --with-gmp="$INSTALL_PREFIX"
make && make check && make install
