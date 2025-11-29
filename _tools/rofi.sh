#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$TOOLS_HOME/rofi" ]; then
  git clone git@github.com:davatorium/rofi.git "$TOOLS_HOME/rofi"
fi

cd "$TOOLS_HOME/rofi" || return
git pull
./configure --prefix="$INSTALL_PREFIX" --disable-check
make
make install
