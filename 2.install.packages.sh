#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)" # script directory

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh) --unattended"

# ZSH Plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
git clone https://github.com/Sparragus/zsh-auto-nvm-use ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-auto-nvm-use

mkdir $NVM_DIR
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
nvm install stable
nvm use stable

brew install python3
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py --user
python3 -m pip install --upgrade pip
python3 -m pip install virtualenv --user
python3 -m pip install http-prompt --user

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup toolchain install stable

cargo install \
  nomino \
  fastmod \
  gitui \
  grex \
  hyperfine \
  lsd \
  nomino \
  sd \
  sic

brew install $(cat brew_packages.txt | xargs)

sudo softwareupdate --install-rosetta
sudo xcodebuild -license accept

brew install --cask $(cat brew_cask_packages.txt | xargs)


https://desktop.docker.com/mac/main/arm64/Docker.dmg?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-mac-arm64

mas install 824183456 # affinity photo
mas install 824171161 # affinity designer
mas install 405843582 # alfred
mas install 872698314 # money money
mas install 1384080005 # tweetbot