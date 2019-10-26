#!/bin/sh

#Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1

#Set a shorter Delay until key repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 12

#Disable mouse acceleration
defaults write .GlobalPreferences com.apple.mouse.scaling -1

#Add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

#Show the ~/Library folder
chflags nohidden ~/Library

#Store screenshots in subfolder on desktop
mkdir ~/Desktop/Screenshots
defaults write com.apple.screencapture location ~/Desktop/Screenshots

# Set git config values
git config --global user.name "Michael Malura"
git config --global user.email "michael@malura.de"
git config --global github.user maluramichael
git config --global github.token YOUR_TOKEN_HERE
git config --global color.ui true

#Restart Finder
sudo pkill Finder
