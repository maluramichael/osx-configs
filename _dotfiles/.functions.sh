#!/bin/bash

changejava() {
  export JAVA_HOME=$(/usr/libexec/java_home -v$1)
  echo $JAVA_HOME
  java --version
}

ips() {
  ip addr | grep "inet\\b" | awk '{print $2}' | cut -d/ -f1
}

mcd() {
  [ ! -d "$1" ] && mkdir -p "$1" && cd "$1" || exit
}

mans() {
  man "$1" | grep -iC2 --color=always "$2" | less
}

gotodev() {
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

nb() {
    clip="$(pbpaste)"
    [[ $clip =~ "https:\/\/lulububu\.atlassian\.net\/browse\/([A-Z0-9]+-[0-9]+)" ]]

    type=$1
    shift
    old="$IFS"
    IFS='-'
    description="$*"
    IFS=$old

    if [ ! "$match" ]; then
        echo "Copy Ticket ID first"
    else
        if [ ! -z "$description" ]; then
          if [ "$type" = "b" ]; then
              git checkout -b "bugfix/$match-$description"
          elif [ "$type" = "f" ]; then
              git checkout -b "feature/$match-$description"
          fi

          git push --set-upstream origin "feature/$match-$description"
        fi
    fi
}

runtests() {
  if [ -f package.json ]; then
    echo "Run npm tests"
    npm run test --if-present
  fi

  if [ -f .tools/run-tests.sh ]; then
    echo "Run lulububu tests"
    .tools/run-tests.sh
  elif [ -f bin/simple-phpunit ]; then
    echo "Run php unit tests"
    bin/simple-phpunit
  fi
}

gb(){
  if [ $# -eq 0 ]; then
    git branch | fzf --print0 -m | tr -d '[:space:]*' |xargs -0 -t -o git checkout
  else
    git checkout "$@"
  fi
}

lfcd() {
  lf "$@"
}

zle -N gb; bindkey '^b' gb
zle -N lfcd; bindkey '^o' lfcd
