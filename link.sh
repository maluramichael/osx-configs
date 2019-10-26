#!/bin/bash

echo "Link from $PWD to $HOME"

# ZSH
if test -f "$HOME/.zshrc" && ! test -h "$HOME/.zshrc"; then mv "$HOME/.zshrc" "$HOME/.zshrc.bak"; fi
if ! test -f "$HOME/.zshrc"; then ln -s "$PWD/.zshrc" "$HOME/.zshrc"; fi

mkdir -p "$HOME/.oh-my-zsh/themes"
if ! test -h "$HOME/.oh-my-zsh/themes/devnetik.zsh-theme"; then
  ln -s "$PWD/.oh-my-zsh/themes/devnetik.zsh-theme" "$HOME/.oh-my-zsh/themes/devnetik.zsh-theme"
fi

# Bash
if test -f "$HOME/.profile" && ! test -h "$HOME/.profile"; then mv "$HOME/.profile" "$HOME/.profile.bak"; fi
if ! test -f "$HOME/.profile"; then ln -s "$PWD/.profile" "$HOME/.profile"; fi

# NPM
if test -f "$HOME/.npmrc" && ! test -h "$HOME/.npmrc"; then mv "$HOME/.npmrc" "$HOME/.npmrc.bak"; fi
if ! test -f "$HOME/.npmrc"; then ln -s "$PWD/.npmrc" "$HOME/.npmrc"; fi

# GIT
if test -f "$HOME/.gitconfig" && ! test -h "$HOME/.gitconfig"; then mv "$HOME/.gitconfig" "$HOME/.gitconfig.bak"; fi
if ! test -f "$HOME/.gitconfig"; then ln -s "$PWD/.gitconfig" "$HOME/.gitconfig"; fi

# CONKY
if test -f "$HOME/.conkyrc" && ! test -h "$HOME/.conkyrc"; then mv "$HOME/.conkyrc" "$HOME/.conkyrc.bak"; fi
if ! test -f "$HOME/.conkyrc"; then ln -s "$PWD/.conkyrc" "$HOME/.conkyrc"; fi

if [ -d "$HOME/.conky.d" ]; then
  if ! test -h "$HOME/.conky.d"; then
    mv "$HOME/.conky.d" "$HOME/.conky.d.bak/"
  fi
fi
if [ ! -d "$HOME/.conky.d" ]; then
  ln -s "$PWD/.conky.d" "$HOME/.conky.d"
fi

# SHELL
if [ -d "$HOME/.shell" ]; then
  if ! test -h "$HOME/.shell"; then
    mv "$HOME/.shell" "$HOME/.shell.bak/"
  fi
fi
if [ ! -d "$HOME/.shell" ]; then
  ln -s "$PWD/.shell" "$HOME/.shell"
fi
