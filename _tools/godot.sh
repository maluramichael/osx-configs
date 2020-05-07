#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$TOOLS_HOME/godot" ]; then
  git clone git@github.com:godotengine/godot.git "$TOOLS_HOME/godot"
fi

cd "$TOOLS_HOME/godot" || return
git pull
scons platform=x11 target=debug bits=64 use_llvm=yes
