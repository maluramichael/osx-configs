#!/bin/sh
echo 'install brew...'
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install caskroom/cask/brew-cask

echo 'brew system...'
brew install zsh zsh-completions
chsh -s /bin/zsh $USER

brew install watch
brew install wget
brew install imagemagick
brew install graphicsmagick
brew install watchman
brew install speedtest_cli
brew install nmap
brew install htop
brew install unrar
brew install irssi
brew install rename
brew install trash
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
brew install curl
brew install sdl2
brew install sfml
brew install doxygen
brew install awscli
brew install allegro
brew install jq
brew install hub
brew install httpie
brew install xmake
brew install ffmpeg --with-fdk-aac --with-fontconfig --with-freetype --with-frei0r --with-libass --with-libbluray --with-libbs2b --with-libcaca --with-libebur128 --with-libsoxr --with-libssh --with-libtesseract --with-libvidstab --with-libvorbis --with-libvpx --with-opencore-amr --with-openh264 --with-openjpeg --with-openssl --with-opus --with-rtmpdump --with-rubberband --with-schroedinger --with-sdl2 --with-snappy --with-speex --with-tesseract --with-theora --with-tools --with-webp --with-x265 --with-xz --with-zeromq --with-zimg

brew cask install java
brew cask install iterm2
brew cask install atom
brew cask install webstorm
brew cask install clion
brew cask install datagrip
brew cask install dash
brew cask install macdown
brew cask install paw
brew cask install dash
brew cask install reactotron
brew cask install docker-toolbox

echo 'brew web...'
brew cask install jdownloader
brew cask install dropbox
brew cask install google-chrome
brew cask install firefox
brew cask install hipchat
brew cask install skype
brew cask install teamviewer
brew cask install gitter

# echo 'app store...'
# window tidy
# xcode
# reeder
# affinity designer
# affinity photo
# airmail
# moneymoney

echo 'games...'
brew cask install steam
brew cask install battle-net
open -a /usr/local/Caskroom/battle-net/latest/Battle.net-Setup.app

brew cask install gog-galaxy
brew cask install league-of-legends

echo 'reset...'
cd $HOME
