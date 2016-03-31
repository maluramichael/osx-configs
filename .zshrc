export ZSH=/Users/socialbit/.oh-my-zsh
ZSH_THEME="gallois"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
plugins=(git docker brew z rails rbenv)
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
source $ZSH/oh-my-zsh.sh
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# nvm
export NVM_DIR="/Users/socialbit/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# android
export ANDROID_HOME=/usr/local/opt/android-sdk

# php
export PATH=/usr/local/php5/bin:$PATH

# rbenv
eval "$(rbenv init -)"

# git
alias clean-branches="git stash && git checkout develop && git branch --merged | grep -v master | grep -v develop | xargs git branch -d"

# react-native
alias packager="./node_modules/react-native/packager/packager.sh --reset-cache"

# symfony
alias screate-database="php bin/console doctrine:database:create"
alias sgenerate-entity="php bin/console doctrine:generate:entity"
alias sgenerate-entities="php bin/console doctrine:generate:entities"
alias supdate-schema="php bin/console doctrine:schema:update"

