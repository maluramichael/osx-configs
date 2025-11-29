#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$TOOLS_HOME/make" ]; then
  git clone https://git.savannah.gnu.org/git/make.git "$TOOLS_HOME/make"
fi

cd "$TOOLS_HOME/make" || return
git pull
./bootstrap --prefix="$INSTALL_PREFIX"
./configure
make
make install
