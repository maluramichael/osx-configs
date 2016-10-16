# loader
alias loadnvm='[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"'
alias loadrbenv='eval "$(rbenv init -)"'

# git
alias deletemergedbrances="git stash && git checkout develop && git branch --merged | grep -v master | grep -v develop | xargs git branch -d"
alias g=git
alias ga='git add'
alias gb='git branch'
alias gba='git branch -a'
alias gc='git commit -v'
alias gl='git pull'
alias gp='git push'
alias gpf='git push --force'
alias gst='git status -sb'
alias gsd='git svn dcommit'
alias gsr='git svn rebase'
alias gs='git stash'
alias gsa='git stash apply'
alias gr='git stash && git svn rebase && git svn dcommit && git stash pop' # git refresh
alias gd='git diff | $GIT_EDITOR -'
alias gmv='git mv'
alias gho='$(git remote -v 2> /dev/null | grep github | sed -e "s/.*git\:\/\/\([a-z]\.\)*/\1/" -e "s/\.git.*//g" -e "s/.*@\(.*\)$/\1/g" | tr ":" "/" | tr -d "\011" | sed -e "s/^/open http:\/\//g" | uniq)'

# HG ALIASES
alias hgst='hg status'
alias hgd='hg diff | $GIT_EDITOR -'
alias hgo='hg outgoing'

# react-native
alias reactotron="node_modules/.bin/reactotron"
alias packagerrunning="lsof -n -i4TCP:8081 | grep LISTEN"
alias packagerpid="lsof -n -i4TCP:8081 | grep LISTEN | awk '{print $2}'"
alias startpackager="./node_modules/react-native/packager/packager.sh --reset-cache"
alias stoppackager="kill -9 $(lsof -n -i4TCP:8081 | grep node | awk '{print $2}')"

# symfony
alias sfconsole="php bin/console "
alias sfcreatedatabase="sfconsole doctrine:database:create"
alias sfgenerateentity="sfconsole doctrine:generate:entity"
alias sfgenerateentities="sfconsole doctrine:generate:entities"
alias sfupdateschema="sfconsole doctrine:schema:update"
alias sfcacheclear="sfconsole cache:clear"
alias sfserverrun="sfconsole server:run"
alias sfbehat="vendor/bin/behat"

# php
alias composer4g="php -d memory_limit=4G /usr/local/bin/composer"

# hunter
alias hunter-get="wget https://raw.githubusercontent.com/hunter-packages/gate/master/cmake/HunterGate.cmake"

# random tools
alias downloadyoutubevideoasmp3="youtube-dl --extract-audio --audio-format mp3 --"

# shell
alias l='ls -lah'   # Long view, show hidden
alias la='ls -AF'   # Compact view, show hidden
alias ll='ls -lFh'  # Long view, no hidden
alias reload="source ~/.zshrc"

# Mac Helpers
alias showhiddenfiles="defaults write com.apple.Finder AppleShowAllFiles YES && killall Finder"
alias hidehiddenfiles="defaults write com.apple.Finder AppleShowAllFiles NO && killall Finder"

# Helpers
alias grep='grep --color=auto' # Always highlight grep search term
alias ping='ping -c 5'      # Pings with 5 packets, not unlimited
alias df='df -h'            # Disk free, in gigabytes, not bytes
alias du='du -h -c'         # Calculate total disk usage for a folder
alias clr='clear;echo "Currently logged in on $(tty), as $(whoami) in directory $(pwd)."'
alias dus='du -sckx * | sort -nr'
alias upgrade-pip='pip install --upgrade pip'

# tools
alias serve='python3 -m http.server 9988'
