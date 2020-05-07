#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$TOOLS_HOME/radare2" ]; then
  git clone git@github.com:radareorg/radare2.git "$TOOLS_HOME/radare2"
fi

cd "$TOOLS_HOME/radare2" || return
git pull
./configure --prefix="$INSTALL_PREFIX"
make
make install
