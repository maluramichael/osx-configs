#!/bin/sh
echo 'install brew...'
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install caskroom/cask/brew-cask

echo 'brew system...'
brew install zsh zsh-completions
chsh -s /bin/zsh $USER

brew install wakeonlan
brew install watch
brew install wget
brew install imagemagick
brew install graphicsmagick
brew install watchman
brew install nmap
brew install htop
brew install unrar
brew install weechat
brew install rename
brew install trash

brew cask install adapter
brew cask install blender
brew cask install istat-menus
brew cask install alfred
brew cask install shuttle
brew cask install vlc
brew cask install iina
brew cask install 1password
brew cask install cakebrew
brew cask install charles
brew cask install love
brew cask install filezilla
brew cask install spotify

echo 'brew development tools...'
brew install git
brew install git-flow
brew install nvm
brew install rbenv
brew install android-sdk
brew install python3
brew install ack
brew install automake
brew install cmake
brew install colordiff
brew install mitmproxy
brew install curl
brew install sdl2
brew install sfml csfml
brew install doxygen
brew install awscli
brew install allegro
brew install jq
brew install hub
brew install httpie
brew install xmake
brew install ffmpeg

brew cask install java
brew cask install iterm2
brew cask install macdown
brew cask install paw
brew cask install dash
brew cask install tower
brew cask install jetbrains-toolbox
brew cask install visual-studio-code visual-studio-code-insiders

echo 'brew web...'
brew cask install jdownloader
brew cask install dropbox
brew cask install google-chrome
brew cask install chromium
brew cask install firefox

# echo 'app store...'
# window tidy
# xcode
# reeder
# affinity designer
# affinity photo
# airmail
# moneymoney

echo 'zsh plugins...'
git clone git://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions

echo 'games...'
brew cask install steam
brew cask install battle-net
open -a /usr/local/Caskroom/battle-net/latest/Battle.net-Setup.app

brew cask install gog-galaxy
brew cask install league-of-legends

echo 'rust...'
curl https://sh.rustup.rs -sSf | sh

echo 'reset...'
cd $HOME
