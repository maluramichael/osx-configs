#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset
shopt -s nullglob

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "$__dir/_tools" || return
tools=()

index=0
for script in *.sh; do
  tools+=("${script%.sh}" "" off)
  ((index += 1))
done

scripts=$(dialog --separate-output --checklist "Select options:" 50 50 30 "${tools[@]}" --output-fd 1)

for script in $scripts; do
  if [ -x "$(command -v figlet)" ]; then
    figlet "${script}"
  fi
  bash "${__dir}/_tools/${script}.sh" -H || break
done
