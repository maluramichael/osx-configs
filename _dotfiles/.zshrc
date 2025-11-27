#!/usr/bin/env zsh
# =============================================================================
#
#  ███████╗███████╗██╗  ██╗██████╗  ██████╗
#  ╚══███╔╝██╔════╝██║  ██║██╔══██╗██╔════╝
#    ███╔╝ ███████╗███████║██████╔╝██║
#   ███╔╝  ╚════██║██╔══██║██╔══██╗██║
#  ███████╗███████║██║  ██║██║  ██║╚██████╗
#  ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝
#
#  Michael Malura's ZSH Configuration
#  https://github.com/malura/osx-configs
#
# =============================================================================

# =============================================================================
# SECTION: Performance Profiling
# Usage: ZPROF=1 zsh -i -c exit
# =============================================================================
[[ -n "$ZPROF" ]] && zmodload zsh/zprof

# =============================================================================
# SECTION: Core Functions (loaded first - other sections depend on these)
# =============================================================================

# Add directory to PATH if it exists and isn't already present
add_to_path() {
    [[ -d "$1" && ":$PATH:" != *":$1:"* ]] && PATH="$1:$PATH"
}

# Append to PATH (adds at end instead of beginning)
append_path() {
    [[ -d "$1" && ":$PATH:" != *":$1:"* ]] && PATH="$PATH:$1"
}

# =============================================================================
# SECTION: Environment Variables
# =============================================================================

# Locale
export LANG=en_GB.UTF-8
export LC_CTYPE=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8
export TERM=xterm-256color

# Directories
export DEV_HOME="$HOME/development"
export WORK_HOME="$DEV_HOME/lulububu"
export WORKON_HOME="$DEV_HOME/virtualenvs"
export PROJECT_HOME="$DEV_HOME/projects"
export LIBS_HOME="$DEV_HOME/libs"
export TOOLS_HOME="$HOME/tools"

# Development Tools
export COMPOSER_HOME="$HOME/.composer"
export SYMFONY_HOME="$HOME/.symfony"
export CARGO_HOME="$DEV_HOME/cargo"
export RUSTUP_HOME="$DEV_HOME/rustup"
export GOPATH="$DEV_HOME/go"
export NVM_DIR="$DEV_HOME/nvm"
export BUN_INSTALL="$HOME/.bun"
export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"

# Java
[[ -x /usr/libexec/java_home ]] && export JAVA_HOME="$(/usr/libexec/java_home -v 17 2>/dev/null)"

# Editor
export EDITOR="nvim"
export VISUAL="nvim"

# Tool Configuration
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_ANALYTICS=1
export COMPOSER_MEMORY_LIMIT=-1
export PHP_MEMORY_LIMIT=-1
export PHP_CS_FIXER_IGNORE_ENV=true
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export PYTHONDONTWRITEBYTECODE=1
export REACT_EDITOR=code
export _JAVA_AWT_WM_NONREPARENTING=1

# Build Tools
export CC="gcc"
export CXX="g++"
export MAKEFLAGS="-j$(sysctl -n hw.ncpu 2>/dev/null || nproc 2>/dev/null || echo 4)"
export INSTALL_PREFIX="$HOME/.local"

# Lulububu
export LULUBUBU_USER_NAME="Michael Malura"

# FZF
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
if command -v fd &>/dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# =============================================================================
# SECTION: PATH Configuration
# =============================================================================

# Homebrew (Apple Silicon and Intel)
add_to_path "/opt/homebrew/bin"
add_to_path "/opt/homebrew/sbin"
add_to_path "/usr/local/bin"
add_to_path "/usr/local/sbin"

# Local binaries
add_to_path "$HOME/.local/bin"

# Development tools
add_to_path "$JAVA_HOME/bin"
add_to_path "$GOPATH/bin"
add_to_path "$CARGO_HOME/bin"
add_to_path "$BUN_INSTALL/bin"
add_to_path "$HOME/.yarn/bin"

# PHP/Composer
add_to_path "$COMPOSER_HOME/vendor/bin"
add_to_path "$SYMFONY_HOME/bin"

# Python
add_to_path "$HOME/Library/Python/3.12/bin"
add_to_path "$HOME/Library/Python/3.11/bin"

# Android
add_to_path "$ANDROID_SDK_ROOT/platform-tools"
add_to_path "$ANDROID_SDK_ROOT/emulator"

# PostgreSQL
add_to_path "/opt/homebrew/opt/postgresql@16/bin"

# Go
if command -v go &>/dev/null; then
    export GOBIN="$(go env GOPATH)/bin"
    add_to_path "$GOBIN"
fi

# CDPATH for quick navigation
export CDPATH=".:$PROJECT_HOME:$WORK_HOME:$TOOLS_HOME:$HOME"

# Completions
fpath=(~/.local/bin/completions $fpath)

# =============================================================================
# SECTION: Oh-My-Zsh Configuration
# =============================================================================

export ZSH="$HOME/.oh-my-zsh"
ZSH_CUSTOM="$HOME/.zsh"
ZSH_THEME="malura"

# Performance
DISABLE_AUTO_UPDATE=true
DISABLE_UNTRACKED_FILES_DIRTY=true
COMPLETION_WAITING_DOTS="true"

# Tmux
ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOSTART_ONCE=true
ZSH_TMUX_AUTOCONNECT=true
ZSH_TMUX_UNICODE=true

# Autosuggestions
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Plugins
plugins=(
    fzf
    git
    node
    npm
    rust
    tmux
    virtualenv
    z
    zsh-autosuggestions
    zsh-completions
    zsh-history-substring-search
    zsh-syntax-highlighting
)

# Load Oh-My-Zsh
[[ -f "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"

# =============================================================================
# SECTION: Completion System
# =============================================================================

autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
    compinit
else
    compinit -C
fi

# =============================================================================
# SECTION: ZSH Options
# =============================================================================

setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt CORRECT
setopt EXTENDED_GLOB
setopt NO_BEEP
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY

# History
export HISTSIZE=100000
export SAVEHIST=100000
export HISTFILE="$HOME/.zsh_history"

# =============================================================================
# SECTION: Key Bindings
# =============================================================================

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

# =============================================================================
# SECTION: Aliases - Navigation
# =============================================================================

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ~="cd ~"
alias -- -="cd -"

# =============================================================================
# SECTION: Aliases - File Listing
# =============================================================================

if command -v eza &>/dev/null; then
    alias ls='eza --group-directories-first'
    alias l='eza -la --group-directories-first --git'
    alias la='eza -a --group-directories-first'
    alias ll='eza -l --group-directories-first --git'
    alias lt='eza -la --tree --level=2 --group-directories-first'
    alias lr='eza -la --tree --group-directories-first'
else
    alias l='ls -lAh'
    alias la='ls -Ah'
    alias ll='ls -lFh'
    alias lr='ls -R'
fi

# =============================================================================
# SECTION: Aliases - File Operations
# =============================================================================

alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'
alias rm='rm -iv'
alias move='rsync -avhr --progress --remove-source-files'

# =============================================================================
# SECTION: Aliases - Editors
# =============================================================================

alias vi='nvim'
alias vim='nvim'
alias v='nvim'

# =============================================================================
# SECTION: Aliases - Git
# =============================================================================

alias g="git"
alias gs="git status -sb"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git pull"
alias glog="git log --oneline --graph --decorate -20"
alias gdf="git diff"
alias gco="git checkout"
alias gsw="git switch"

# =============================================================================
# SECTION: Aliases - Docker
# =============================================================================

alias d='docker'
alias dc='docker compose'
alias dps='docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dpsa='docker ps -a --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Size}}"'
alias docker-remove-exited='docker rm $(docker ps -aq -f status=exited) 2>/dev/null'

# =============================================================================
# SECTION: Aliases - System
# =============================================================================

alias c='clear'
alias clr='clear && echo "$(whoami)@$(hostname) in $(pwd)"'
alias path='print -l ${(s/:/)PATH}'
alias df='df -h'
alias du='du -h -c'
alias dus='du -sh * | sort -hr'
alias grep='grep --color=auto'
alias ping='ping -c 5'
alias ports='lsof -i -P -n | grep LISTEN'
alias localip='ipconfig getifaddr en0 2>/dev/null || ipconfig getifaddr en1'
alias less='less -FSRXc'

if [[ "$OSTYPE" == darwin* ]]; then
    alias reboot='sudo shutdown -r now'
    alias poweroff='sudo shutdown -h now'
    alias sleep='pmset sleepnow'
else
    alias reboot='sudo systemctl reboot'
    alias poweroff='sudo systemctl poweroff'
fi

# =============================================================================
# SECTION: Aliases - Package Managers
# =============================================================================

alias bruh="brew"
alias brewup='brew update && brew upgrade && brew cleanup'

# =============================================================================
# SECTION: Aliases - Media
# =============================================================================

if command -v yt-dlp &>/dev/null; then
    alias ytdl='yt-dlp'
    alias ytmp3='yt-dlp -x --audio-format mp3'
    alias ytvid='yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best"'
fi

# =============================================================================
# SECTION: Aliases - PHP/Symfony
# =============================================================================

alias sfcc='sf cache:clear'
alias sfm='sf doctrine:migrations:migrate'
alias sfdu='sf app:data:update'
alias sfdc='sf doctrine:database:create'
alias sfsu='sf doctrine:schema:update --dump-sql --complete --force'
alias php82debug='php82 -dxdebug.mode=debug -dxdebug.client_port=9003 -dxdebug.client_host=127.0.0.1 -dxdebug.start_with_request=yes'

# Lulububu
alias bugfix='lb git new_bugfix'
alias feature='lb git new_feature'
alias disable_hooks='git config core.hooksPath .disabled'
alias enable_hooks='git config core.hooksPath node_modules/@lulububu/skeleton-base-package/githooks'

# =============================================================================
# SECTION: Aliases - Utilities
# =============================================================================

alias now='date +"%Y-%m-%d %H:%M:%S"'
alias week='date +%V'
alias weather='curl -s "wttr.in?format=3"'
alias serve='python3 -m http.server 8000'
alias json='python3 -m json.tool'
alias find_empty_dirs="find . -type d -empty"
alias remove_empty_dirs="find . -type d -empty -delete"

# Quick config editing
alias zshrc='${EDITOR:-nvim} ~/.zshrc'
alias reload='source ~/.zshrc && echo "Configuration reloaded"'

# =============================================================================
# SECTION: Functions - Navigation
# =============================================================================

# Make directory and cd into it
mcd() {
    [[ -z "$1" ]] && { echo "Usage: mcd <directory>"; return 1; }
    mkdir -p "$1" && cd "$1"
}

# Quick directory bookmarks
dev() { cd "${DEV_HOME:-$HOME/development}" && ls; }
work() { cd "${WORK_HOME:-$DEV_HOME/lulububu}" && ls; }
proj() { cd "${PROJECT_HOME:-$DEV_HOME/projects}" && ls; }

# =============================================================================
# SECTION: Functions - Development
# =============================================================================

# Change Java version
changejava() {
    [[ -z "$1" ]] && { echo "Usage: changejava <version>"; return 1; }
    export JAVA_HOME=$(/usr/libexec/java_home -v"$1" 2>/dev/null)
    [[ -z "$JAVA_HOME" ]] && { echo "Java version $1 not found"; return 1; }
    echo "JAVA_HOME: $JAVA_HOME"
    java --version
}

# Run project tests
runtests() {
    local ran=0
    [[ -f package.json ]] && { echo "Running npm tests..."; npm run test --if-present && ran=1; }
    [[ -f .tools/run-tests.sh ]] && { echo "Running lulububu tests..."; .tools/run-tests.sh && ran=1; }
    [[ -f bin/simple-phpunit ]] && { echo "Running PHPUnit..."; bin/simple-phpunit && ran=1; }
    [[ -f vendor/bin/phpunit ]] && { echo "Running PHPUnit..."; vendor/bin/phpunit && ran=1; }
    [[ $ran -eq 0 ]] && echo "No test framework detected"
}

# Symfony console
sf() {
    if command -v herd &>/dev/null; then
        herd php bin/console "$@"
    elif [[ -f bin/console ]]; then
        php bin/console "$@"
    else
        echo "No Symfony console found"; return 1
    fi
}

# =============================================================================
# SECTION: Functions - Network
# =============================================================================

# Show IP addresses
ips() {
    if [[ "$OSTYPE" == darwin* ]]; then
        ifconfig | grep "inet " | awk '{print $2}'
    else
        ip addr 2>/dev/null | grep "inet\b" | awk '{print $2}' | cut -d/ -f1
    fi
}

# Public IP
myip() { curl -s https://ipinfo.io/ip && echo; }

# =============================================================================
# SECTION: Functions - Files
# =============================================================================

# Extract archives
extract() {
    [[ ! -f "$1" ]] && { echo "'$1' is not a valid file"; return 1; }
    case "$1" in
        *.tar.bz2) tar xjf "$1" ;;
        *.tar.gz)  tar xzf "$1" ;;
        *.tar.xz)  tar xJf "$1" ;;
        *.bz2)     bunzip2 "$1" ;;
        *.rar)     unrar x "$1" ;;
        *.gz)      gunzip "$1" ;;
        *.tar)     tar xf "$1" ;;
        *.tbz2)    tar xjf "$1" ;;
        *.tgz)     tar xzf "$1" ;;
        *.zip)     unzip "$1" ;;
        *.Z)       uncompress "$1" ;;
        *.7z)      7z x "$1" ;;
        *)         echo "'$1' cannot be extracted" ;;
    esac
}

# Backup file
backup() {
    [[ ! -f "$1" ]] && { echo "'$1' is not a valid file"; return 1; }
    cp "$1" "$1.bak.$(date +%Y%m%d_%H%M%S)"
}

# Find files
ff() {
    [[ -z "$1" ]] && { echo "Usage: ff <pattern>"; return 1; }
    if command -v fd &>/dev/null; then fd "$1"; else find . -name "*$1*" -type f 2>/dev/null; fi
}


# =============================================================================
# SECTION: Functions - Docker
# =============================================================================

docker-stop-all() { docker stop $(docker ps -q) 2>/dev/null || echo "No running containers"; }
docker-rm-stopped() { docker rm $(docker ps -aq -f status=exited) 2>/dev/null || echo "No stopped containers"; }
docker-cleanup() {
    echo "Stopping containers..."; docker-stop-all
    echo "Removing stopped..."; docker-rm-stopped
    echo "Pruning system..."; docker system prune -f
}

# =============================================================================
# SECTION: Functions - Utilities
# =============================================================================

# Search man pages
mans() {
    [[ $# -lt 2 ]] && { echo "Usage: mans <command> <term>"; return 1; }
    man "$1" | grep -iC2 --color=always "$2" | less -R
}

# Print PATH
printpath() { print -l ${(s/:/)PATH}; }

# Print colors
printcolors() {
    for i in {0..255}; do
        printf "\x1b[48;5;%sm%3d\e[0m " "$i" "$i"
        ((i == 7)) && printf "\n"
        ((i == 15 || (i > 15 && (i - 15) % 6 == 0))) && printf "\n"
    done
}

# Virtualenv info for prompt
virtualenv_info() { [[ -n "$VIRTUAL_ENV" ]] && echo "($(basename $VIRTUAL_ENV)) "; }

# Download video
video() {
    local url="${1:-$(pbpaste)}"
    [[ -z "$url" ]] && { echo "Usage: video <url>"; return 1; }
    ssh home_vault "/tank/scripts/media_downloader/video '$url'"
}

# =============================================================================
# SECTION: Functions - Profiling
# =============================================================================

zsh-profile() { ZPROF=1 zsh -i -c exit; }
zsh-benchmark() {
    for i in {1..10}; do /usr/bin/time zsh -i -c exit 2>&1; done | grep real | awk '{sum+=$1} END {print "Average: " sum/NR "s"}'
}

# =============================================================================
# SECTION: NVM - Lazy Loading
# =============================================================================

if [[ -d "$NVM_DIR" ]]; then
    nvm() {
        unset -f nvm node npm npx
        [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
        nvm "$@"
    }
    node() {
        unset -f nvm node npm npx
        [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
        node "$@"
    }
    npm() {
        unset -f nvm node npm npx
        [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
        npm "$@"
    }
    npx() {
        unset -f nvm node npm npx
        [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
        npx "$@"
    }
fi

# =============================================================================
# SECTION: External Integrations
# =============================================================================

# Platform.sh
if [[ -f "$HOME/.platformsh/shell-config.rc" ]]; then
    add_to_path "$HOME/.platformsh/bin"
    source "$HOME/.platformsh/shell-config.rc"
fi

# Bun
[[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"

# Cargo
[[ -f "$CARGO_HOME/env" ]] && source "$CARGO_HOME/env"

# =============================================================================
# SECTION: Local Overrides (create ~/.zshrc.local for machine-specific config)
# =============================================================================

[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

# =============================================================================
# SECTION: Profiling Output
# =============================================================================

[[ -n "$ZPROF" ]] && zprof
