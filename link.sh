#!/bin/sh

currentDirectory=$(pwd)
cd $HOME

mkdir -p .shell .oh-my-zsh/themes

ln -sf "$currentDirectory/.shell" .shell
ln -sf "$currentDirectory/.zshrc" .zshrc
ln -sf "$currentDirectory/.npmrc" .npmrc
ln -sf "$currentDirectory/.gitconfig" .gitconfig
ln -sf "$currentDirectory/.oh-my-zsh/themes/devnetik.zsh-theme" ".oh-my-zsh/themes/devnetik.zsh-theme"
