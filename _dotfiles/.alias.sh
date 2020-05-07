# git
alias remove-merged-branches="git stash && git checkout develop && git branch --merged | grep -v master | grep -v develop | xargs git branch -d"

# random tools
alias downloadyoutubevideoasmp3="youtube-dl --extract-audio --audio-format mp3 --"

# shell
alias l='ls -lahi' # Long view, show hidden
alias la='ls -AFh' # Compact view, show hidden
alias ll='ls -lFh' # Long view, no hidden
alias reload="source ~/.zshrc"
alias remove_empty_dirs="find . -type d -empty"

# Update existing commands
alias grep='grep --color=auto' # Always highlight grep search term
alias ping='ping -c 5'         # Pings with 5 packets, not unlimited
alias df='df -h'               # Disk free, in gigabytes, not bytes
alias du='du -h -c'            # Calculate total disk usage for a folder

alias clr='clear;echo "Currently logged in on $(tty), as $(whoami) in directory $(pwd)."'
alias dus='du -sckx * | sort -nr'

# docker
alias docker-remove-exited-container="docker ps -a | grep Exit | cut -d ' ' -f 1 | xargs docker rm"
alias docker-ps-short='docker ps -a --format "table {{.ID}}\t{{.Names}}\t{{.Size}}\t{{.Status}}" | grep -v CONTAINER'

alias cp='cp -iv'                   # Preferred 'cp' implementation
alias mv='mv -iv'                   # Preferred 'mv' implementation
alias mkdir='mkdir -pv'             # Preferred 'mkdir' implementation
alias ll='ls -FGlAhp'               # Preferred 'ls' implementation
alias less='less -FSRXc'            # Preferred 'less' implementation
alias cd..='cd ../'                 # Go back 1 directory level (for fast typers)
alias ..='cd ../'                   # Go back 1 directory level
alias ...='cd ../../'               # Go back 2 directory levels
alias .3='cd ../../../'             # Go back 3 directory levels
alias .4='cd ../../../../'          # Go back 4 directory levels
alias .5='cd ../../../../../'       # Go back 5 directory levels
alias .6='cd ../../../../../../'    # Go back 6 directory levels
alias ~="cd ~"                      # ~:            Go Home
alias c='clear'                     # c:            Clear terminal display
alias path='echo -e ${PATH//:/\\n}' # path:         Echo all executable Paths
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'
alias numFiles='echo $(ls -1 | wc -l)' # numFiles:     Count of non-hidden files in current dir

alias searchl='locate $PWD | fzf -m --preview "cat {}"'
alias search='locate / | fzf -m --preview "cat {}"'

alias reboot="sudo systemctl reboot"
alias poweroff="sudo systemctl poweroff"
alias halt="sudo systemctl halt"


# lulububu
alias sf="php ./bin/console"
alias sfcc="sf cache:clear"
alias sfsu="sf doctrine:schema:update --force"
alias sfsv="sf doctrine:schema:validate"
alias sfnd="sf doctrine:database:drop --force && sf doctrine:database:create && sfsu"

alias sf="php ./bin/console"
alias sfcc="sf cache:clear"
alias sfsu="sf doctrine:schema:update --force"
alias sfsv="sf doctrine:schema:validate"
alias sfnd="sf doctrine:database:drop --force && sf doctrine:database:create && sfsu"

alias dev="git checkout develop && git pull && gulp dev"
alias dev-rn="git checkout develop && git pull && rn start"
alias composer4g="php -d memory_limit=4G  /usr/local/bin/composer"

alias git-clean="git branch --merged | egrep -v \"(^\*|master|dev)\" | xargs git branch -d"

nb() {
    clip="$(pbpaste)"
    [[ $clip =~ "https:\/\/lulububu\.atlassian\.net\/browse\/([A-Z0-9]+-[0-9]+)" ]]

    if [ ! "$match" ]; then
        echo "Copy Ticket ID first"
    else
        if [ "$1" = "b" ]; then
            git checkout -b "bugfix/$match-$2"
        elif [ "$1" = "f" ]; then
            git checkout -b "feature/$match-$2"
        fi
    fi
}

alias rn="react-native"
alias rnra="rn run-android"
alias rnri="rn run-ios"
alias rnrun="rnra && rnri"
alias fix-glog="cd ./node_modules/react-native/third-party/glog-0.* && ../../scripts/ios-configure-glog.sh && cd ../../../../"

