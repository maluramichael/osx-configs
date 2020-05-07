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
export WORKON_HOME="$DEV_HOME/virtualenvs"
export PROJECT_HOME="$DEV_HOME/projects"
export LIBS_HOME="$DEV_HOME/libs"
export TOOLS_HOME="$HOME/tools"

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
addToPATH "$HOME/.yarn/bin"
addToPATH "$CARGO_HOME/bin"
addToPATH "/opt/local/bin"
addToPATH "$HOME/Library/Python/3.7/bin"