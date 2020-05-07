#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)" # script directory
__dotfiles="_dotfiles"

link() {
  from="${__dir%/}/${1}"
  to="${HOME%/}${1#${__dotfiles}}"

  if [[ ${1} =~ "/" ]]; then
    directory_structure=$(dirname "$to")

    if [[ ! -d $directory_structure ]]; then
      echo "$directory_structure does not exist"
      mkdir -p "$directory_structure"
    fi
  fi

  if [[ -L "$to" ]]; then
    rm -r "$to"
  fi

  if [ -f "$to" ] || [ -d "$to" ]; then
    echo "Backup existing $to $to.bak"
    mv "$to" "$to.bak"
  fi

  ln -s "$from" "$to"
}

(
  echo "Run link script from $__dir"
  cd "$__dir"
  find "$__dotfiles" -type f | while read -r file; do link "$file"; done
)
