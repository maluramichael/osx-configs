#!/bin/bash

ips() {
  ip addr | grep "inet\\b" | awk '{print $2}' | cut -d/ -f1
}

mcd() {
  [ ! -d "$1" ] && mkdir -p "$1" && cd "$1" || exit
}

mans() {
  man "$1" | grep -iC2 --color=always "$2" | less
}

dev() {
  [ ! -d "$DEV_HOME" ] && mkdir -p "$DEV_HOME"
  cd "$DEV_HOME" || exit
  ls
}

printcolors() {
  for i in {0..255}; do
    printf "\x1b[48;5;%sm%3d\e[0m " "$i" "$i"
    if ((i == 7)); then
      printf "\n"
    fi
    if ((i == 15)) || ((i > 15)) && (((i - 15) % 6 == 0)); then
      printf "\n"
    fi
  done
}

joinby() {
  local IFS="$1"
  shift
  echo "$*"
}

addToPATH() {
  case ":$PATH:" in
    *":$1:"*) :;; # already there
    *) PATH="$1:$PATH";; # or PATH="$PATH:$1"
  esac
}
