#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$LIBS_HOME/lz4" ]; then
  git clone git@github.com:lz4/lz4.git "$LIBS_HOME/lz4"
fi

cd "$LIBS_HOME/lz4" || return
git pull
make
