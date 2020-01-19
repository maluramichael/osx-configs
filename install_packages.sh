#!/bin/sh
chsh -s /bin/zsh $USER

echo 'nvm...'
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash

echo 'rbenv...'
sudo port install rbenv

echo 'python...'
sudo port install python37
sudo port select --set python python37

echo 'pip...'
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py --user

# echo 'app store...'
# window tidy
# xcode
# reeder
# affinity designer
# affinity photo
# airmail
# moneymoney

echo 'zsh plugins...'
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions

echo 'rust...'
curl https://sh.rustup.rs -sSf | sh

echo 'reset...'
cd $HOME
