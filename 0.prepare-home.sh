#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset

# Create essential directories
cd $HOME
mkdir -p development/libs
mkdir -p development/projects
mkdir -p tools
