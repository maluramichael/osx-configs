#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)" # script directory

install_packages() {
  PACKAGES=$(cat ${__dir}/apt.packages.list | awk '{ print $2 }')
  echo "$PACKAGES" | xargs sudo apt-get install -y
  sudo apt install "linux-headers-$(uname -r)"
}

add_keys() {
  # Yarn
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  # VSCode
  curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
  sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
  # Scala
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
  # amd opencl
  wget -qO - http://repo.radeon.com/rocm/apt/debian/rocm.gpg.key | sudo apt-key add -
}

add_repos() {
  # Yarn
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
  # VSCode
  sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
  # Scala
  echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
  # amd opencl
  echo 'deb [arch=amd64] http://repo.radeon.com/rocm/apt/debian/ xenial main' | sudo tee /etc/apt/sources.list.d/rocm.list
}

install_zsh() {
  # ZSH
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh) --unattended"

  # Ohy my zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

  # ZSH Plugins
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
  git clone https://github.com/Sparragus/zsh-auto-nvm-use ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-auto-nvm-use
}

install_nvm() {
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
  nvm install stable
  nvm use stable
  (cd "$NVM_DIR" && git pull origin)
}

install_rust() {
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

install_python() {
  # thanks to https://linuxconfig.org/how-to-change-default-python-version-on-debian-9-stretch-linux
  sudo update-alternatives --install /usr/bin/python python /usr/bin/python2.7 1
  sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.7 2

  curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
  python get-pip.py --user
  pip install --upgrade pip
  pip install virtualenv --user
  pip install http-prompt --user
}

install_tmux() {
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

install_amd_opencl() {
  sudo apt-get install dkms rock-dkms rocm-opencl
}

install_packages
add_keys
add_repos

sudo apt-get update -y

install_zsh
install_nvm
install_rust
install_python
install_tmux
