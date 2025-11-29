#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$LIBS_HOME/llvm" ]; then
    git clone https://github.com/llvm/llvm-project.git "$LIBS_HOME/llvm"
fi

cd "$LIBS_HOME/llvm" || return
git pull
mkdir -p build
cd build || return
cmake \
    -DCMAKE_BUILD_TYPE="Release" \
    -DCMAKE_INSTALL_PREFIX="$INSTALL_PREFIX" \
    -DLLVM_ENABLE_PROJECTS=clang \
    ../llvm
make install
