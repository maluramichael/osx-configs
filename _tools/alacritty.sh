#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

if [ ! -d "$TOOLS_HOME/alacritty" ]; then
  git clone git@github.com:alacritty/alacritty.git "$TOOLS_HOME/alacritty"
fi

cd "$TOOLS_HOME/alacritty" || return
git pull
cargo build --release

sudo cp target/release/alacritty "$HOME/.local/bin"
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database
