#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$TOOLS_HOME/barrier" ]; then
  git clone git@gitlab.kitware.com:barrier/barrier.git "$TOOLS_HOME/barrier"
fi

cd "$TOOLS_HOME/barrier" || return
git pull
mkdir -p build
cd build || return
cmake ..
make
