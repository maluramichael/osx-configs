#!/bin/sh
echo 'install brew...'
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo 'brew development tools...'
brew install git
brew install nvm
brew install rbenv
brew install android-sdk
brew install python3

brew cask install iterm2
brew cask install atom
brew cask install webstorm
brew cask install datagrip
brew cask install dash
brew cask install macdown
brew cask install paw
brew cask install dash

echo 'brew web...'
brew cask install jdownloader
brew cask install dropbox
brew cask install google-chrome
brew cask install firefox
brew cask install hipchat
brew cask install skype
brew cask install teamviewer
brew cask install gitter

echo 'brew system...'
brew install ffmpeg
brew install watch
brew install wget
brew install imagemagick
brew install graphicsmagick

brew cask install whatpulse
brew cask install adapter
brew cask install blender
brew cask install istat-menus
brew cask install alfred
brew cask install shuttle
brew cask install vlc
brew cask install 1password
brew cask install cakebrew
brew cask install charles
brew cask install love
brew cask install filezilla

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
node install -g yarn
node install -g react-native

echo 'rbenv...'
rbenv install 2.3.0
rbenv global 2.3.0

echo 'gems...'
gem install cocoapods
gem install jekyll

echo 'python 2...'
cd $HOME/Temp
wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py

echo 'virtualenv...'
sudo pip3 install virtualenv --upgrade

echo 'reset...'
cd $HOME
