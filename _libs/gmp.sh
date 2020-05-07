#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$LIBS_HOME/mpfr" ]; then
    svn checkout https://scm.gforge.inria.fr/anonscm/svn/mpfr/trunk "$LIBS_HOME/mpfr"
fi

cd "$LIBS_HOME/mpfr" || return
svn update
./configure --disable-shared --enable-static --prefix="$INSTALL_PREFIX"
make && make check && make install
