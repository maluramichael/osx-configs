#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset
shopt -s nullglob

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "$__dir/_libs" || return
libs=()

index=0
for script in *.sh; do
  libs+=("${script%.sh}" "" off)
  ((index += 1))
done

scripts=$(dialog --separate-output --checklist "Select options:" 30 50 30 "${libs[@]}" --output-fd 1)

for script in $scripts; do
  if [ -x "$(command -v figlet)" ]; then
    figlet "${script}"
  fi
  bash "${__dir}/_libs/${script}.sh" -H || break
done
