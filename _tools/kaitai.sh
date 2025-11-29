#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$TOOLS_HOME/kaitai_struct_webide" ]; then
  git clone --recursive https://github.com/kaitai-io/kaitai_struct_webide "$TOOLS_HOME/kaitai_struct_webide"
fi

cd "$TOOLS_HOME/kaitai_struct_webide" || return
git pull
npm install
