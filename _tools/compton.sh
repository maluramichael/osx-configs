#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$TOOLS_HOME/compton" ]; then
  git clone git@github.com:tryone144/compton.git "$TOOLS_HOME/compton" --recurse-submodules
fi

cd "$TOOLS_HOME/compton" || return
git pull
make
PREFIX="$INSTALL_PREFIX" make install
