#!/bin/sh
echo 'nvm...'
nvm install stable
nvm use stable

echo 'node...'
npm install -g nodemon
npm install -g yarn
npm install -g react-native-cli
npm install -g reactotron-cli

echo 'rbenv...'
rbenv install 2.3.0
rbenv global 2.3.0

echo 'gems...'
gem install cocoapods
gem install jekyll

echo 'virtualenv...'
sudo pip3 install virtualenv --upgrade
pip3 install http-prompt
pip install --upgrade pip

echo 'oh my zsh...'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
