#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$LIBS_HOME/pcl" ]; then
  git clone git@github.com:PointCloudLibrary/pcl.git "$LIBS_HOME/pcl"
fi

cd "$LIBS_HOME/pcl" || return
git pull
mkdir -p build
cd build || return
cmake -DCMAKE_BUILD_TYPE="Release" -DCMAKE_INSTALL_PREFIX="$INSTALL_PREFIX" ..
make
make install
