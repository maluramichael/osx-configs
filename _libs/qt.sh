#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$LIBS_HOME/qt5" ]; then
    git clone --recurse-submodules git://code.qt.io/qt/qt5.git --jobs 8 --branch 5.12 "$LIBS_HOME/qt5"
fi

cd "$LIBS_HOME/qt5" || return
git pull --recurse-submodules
./configure -opensource -confirm-license -nomake examples -nomake tests -silent -prefix "$INSTALL_PREFIX/qt5"
make
make install
