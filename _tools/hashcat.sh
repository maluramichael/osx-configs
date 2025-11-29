#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$TOOLS_HOME/hashcat" ]; then
  git clone git@github.com:hashcat/hashcat.git "$TOOLS_HOME/hashcat"
fi

cd "$TOOLS_HOME/hashcat" || return
git pull
