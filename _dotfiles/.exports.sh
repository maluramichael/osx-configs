#!/usr/bin/env bash

CORES=4
export TERMINAL=xterm

# language settings
export LANG=en_GB.UTF-8
export LC_CTYPE=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8

export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3

# useful working directories
export DEV_HOME="$HOME/development"
export WORK_HOME="$DEV_HOME/lulububu"
export WORKON_HOME="$DEV_HOME/virtualenvs"
export PROJECT_HOME="$DEV_HOME/projects"
export LIBS_HOME="$DEV_HOME/libs"
export TOOLS_HOME="$HOME/tools"
export COMPOSER_HOME="$HOME/.composer"
export SYMFONY_HOME="$HOME/.symfony"
export ANDROID_HOME="$HOME/Library/Android/sdk"
export GOPATH="$DEV_HOME/go"

if command -v go &> /dev/null; then
    export GOBIN=$(go env GOPATH)/bin
fi

# react
export REACT_EDITOR=code

# nodejs
export NVM_DIR="$DEV_HOME/nvm"

# rust
export CARGO_HOME="$DEV_HOME/cargo"
export RUSTUP_HOME="$DEV_HOME/rustup"

# make
export CC="gcc"
export CXX="g++"
export MAKEFLAGS="-j$CORES"
export INSTALL_PREFIX="$HOME/.local"

# fix java rendering issues with bspwm
export _JAVA_AWT_WM_NONREPARENTING=1

# set path variable
PATH="$HOME/Library/Python/3.8/bin:/usr/local/opt/php@7.4/bin:$HOME/.yarn/bin:$CARGO_HOME/bin:/opt/local/bin:$COMPOSER_HOME/vendor/bin:$SYMFONY_HOME/bin:$ANDROID_HOME/platform-tools:$PATH"
CDPATH="$CDPATH:$PROJECT_HOME:$TOOLS_HOME:$WORK_HOME:$HOME"

fpath=(~/.local/bin/completions $fpath)
