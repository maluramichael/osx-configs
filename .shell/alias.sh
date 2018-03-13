alias wakevault="wakeonlan 0C:C4:7A:91:91:FD"

# git
alias remove-merged-branches="git stash && git checkout develop && git branch --merged | grep -v master | grep -v develop | xargs git branch -d"
alias b="brew"
alias bc="b cask"
alias bci="bc install"
alias bcs="bc search"
alias bi="b install"
alias bs="b search"

# brew
alias brew-clean-update='brew update && brew cleanup && brew cask cleanup'

# hunter
alias hunter-get="wget https://raw.githubusercontent.com/hunter-packages/gate/master/cmake/HunterGate.cmake"

# random tools
alias downloadyoutubevideoasmp3="youtube-dl --extract-audio --audio-format mp3 --"

# shell
alias l='ls -lahi'   # Long view, show hidden
alias la='ls -AFh'    # Compact view, show hidden
alias ll='ls -lFh'   # Long view, no hidden
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
alias serve3='python3 -m http.server $(( ( RANDOM % 30000 )  + 9000 ))'
alias backup='rsync -aPvh'

# docker
alias docker-remove-exited-container="docker ps -a | grep Exit | cut -d ' ' -f 1 | xargs docker rm"
alias docker-ps-short='docker ps -a --format "table {{.ID}}\t{{.Names}}\t{{.Size}}\t{{.Status}}" | grep -v CONTAINER'
