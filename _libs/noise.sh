#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$LIBS_HOME/noise" ]; then
    cvs -z3 -d:pserver:anonymous@a.cvs.sourceforge.net:/cvsroot/libnoise co -P "$LIBS_HOME/noise"
fi

cd "$LIBS_HOME/noise" || return
cvs update
make clean
make
rsync -rv --exclude CVS --exclude Makefile include/* "$HOME/.local/include/noise"
rsync -rv --exclude CVS --exclude Makefile lib/ "$HOME/.local/lib/"
ln -s "$HOME/.local/lib/libnoise.so.0.3" "$HOME/.local/lib/libnoise.so"
ln -s "$HOME/.local/lib/libnoise.so.0.3" "$HOME/.local/lib/libnoise.so.0"
