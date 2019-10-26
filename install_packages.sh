#!/bin/sh
echo 'install brew...'
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install caskroom/cask/brew-cask

echo 'brew system...'
brew install zsh zsh-completions

brew install $(<brew_packages.txt)
brew cask install $(<brew_cask_packages.txt)

chsh -s /bin/zsh $USER

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
