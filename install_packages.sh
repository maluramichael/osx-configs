#!/bin/sh

echo 'install brew...'
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# brew development tools
echo 'brew development tools...'
brew install git nvm rbenv
brew cask install mysqlworkbench iterm2 atom webstorm dash macdown paw

# brew web
echo 'brew web...'
brew cask install jdownloader dropbox google-chrome hipchat skype teamviewer

# brew system
echo 'brew system...'
brew install ffmpeg
brew cask install whatpulse adapter blender istat-menus alfred shuttle vlc 1password

# install other stuff from app store
# window tidy
# xcode
# reeder
# affinity designer
# affinity photo
# airmail

echo 'nvm...'
nvm install stable
nvm use stable

echo 'node...'
node install -g nodemon

echo 'rbenv...'
rbenv install 2.3.0
rbenv global 2.3.0

echo 'gems...'
gem install cocoapods jekyll
