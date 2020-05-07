#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$LIBS_HOME/kaitai_struct" ]; then
    git clone --recursive https://github.com/kaitai-io/kaitai_struct.git "$LIBS_HOME/kaitai_struct"
fi

cd "$LIBS_HOME/kaitai_struct" || return
git pull
git submodule update --recursive
sbt compilerJVM/universal:packageBin
