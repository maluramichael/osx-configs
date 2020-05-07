#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$LIBS_HOME/exprtk" ]; then
    git clone git@github.com:ArashPartow/exprtk.git "$LIBS_HOME/exprtk"
fi

cd "$LIBS_HOME/exprtk" || return
git pull
