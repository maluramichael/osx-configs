#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$TOOLS_HOME/st" ]; then
  git clone https://git.suckless.org/st "$TOOLS_HOME/st" --recurse-submodules
fi

cd "$TOOLS_HOME/st" || return
git reset --hard HEAD
git pull
curl https://st.suckless.org/patches/desktopentry/st-desktopentry-0.8.2.diff | git apply -v

make
sudo make install
