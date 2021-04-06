#!/bin/bash

export ZSH="$HOME/.oh-my-zsh"

ZSH_CUSTOM="$HOME/.zsh"
ZSH_THEME="malura"
ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOSTART_ONCE=true
ZSH_TMUX_AUTOCONNECT=true
ZSH_TMUX_UNICODE=true
AUTO_CD=false

ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=1

COMPLETION_WAITING_DOTS="true"
plugins=(
  tmux
  fzf
  z
  zsh-autosuggestions
  zsh-history-substring-search
  zsh-syntax-highlighting
  zsh-completions
)
autoload -U compinit && compinit

source ~/.functions.sh
source ~/.exports.sh
source ~/.alias.sh
source ~/.setup.sh
source ~/.profile

source $ZSH/oh-my-zsh.sh
