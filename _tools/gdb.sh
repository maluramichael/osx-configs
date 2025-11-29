#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$TOOLS_HOME/gdb" ]; then
  git clone git://sourceware.org/git/binutils-gdb.git "$TOOLS_HOME/gdb"
fi

cd "$TOOLS_HOME/gdb" || return
git pull
./configure --prefix="$INSTALL_PREFIX"
make
make install
