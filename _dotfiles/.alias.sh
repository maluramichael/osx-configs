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
