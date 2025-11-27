#!/usr/bin/env bash
# =============================================================================
#
#  ██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗
#  ██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝
#  ██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗
#  ██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║
#  ██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║
#  ╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝
#
#  Idempotent dotfiles installer - run as many times as you want
#
# =============================================================================
set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly DOTFILES_DIR="_dotfiles"

# =============================================================================
# Colors and Logging
# =============================================================================
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly MAGENTA='\033[0;35m'
readonly CYAN='\033[0;36m'
readonly BOLD='\033[1m'
readonly DIM='\033[2m'
readonly NC='\033[0m'

log_info()    { echo -e "${BLUE}[*]${NC} $1"; }
log_ok()      { echo -e "${GREEN}[+]${NC} $1"; }
log_warn()    { echo -e "${YELLOW}[!]${NC} $1"; }
log_error()   { echo -e "${RED}[-]${NC} $1"; }
log_skip()    { echo -e "${DIM}[~]${NC} ${DIM}$1${NC}"; }
log_section() { echo -e "\n${BOLD}${CYAN}==> $1${NC}\n"; }

spinner() {
    local pid=$1 msg=$2
    local spin='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
    local i=0
    while kill -0 "$pid" 2>/dev/null; do
        printf "\r${BLUE}[${spin:i++%${#spin}:1}]${NC} %s" "$msg"
        sleep 0.1
    done
    printf "\r"
}

# =============================================================================
# System Detection
# =============================================================================
is_macos() { [[ "$OSTYPE" == darwin* ]]; }
is_linux() { [[ "$OSTYPE" == linux* ]]; }
is_arm()   { [[ "$(uname -m)" == "arm64" ]]; }

# =============================================================================
# Files to skip (merged into .zshrc)
# =============================================================================
readonly SKIP_FILES=(".alias.sh" ".exports.sh" ".functions.sh" ".setup.sh" ".profile" ".zprofile")

should_skip() {
    local file="$1"
    for skip in "${SKIP_FILES[@]}"; do
        [[ "$file" == *"$skip" ]] && return 0
    done
    return 1
}

# =============================================================================
# Directory Setup
# =============================================================================
setup_directories() {
    log_section "Setting up directories"

    local dirs=(
        "$HOME/development"
        "$HOME/development/libs"
        "$HOME/development/projects"
        "$HOME/development/lulububu"
        "$HOME/development/virtualenvs"
        "$HOME/development/nvm"
        "$HOME/development/go"
        "$HOME/development/cargo"
        "$HOME/development/rustup"
        "$HOME/tools"
        "$HOME/.local/bin"
        "$HOME/.local/bin/completions"
        "$HOME/.zsh/themes"
        "$HOME/.config"
    )

    for dir in "${dirs[@]}"; do
        if [[ ! -d "$dir" ]]; then
            mkdir -p "$dir"
            log_ok "Created $dir"
        else
            log_skip "$dir exists"
        fi
    done
}

# =============================================================================
# Dotfile Linking
# =============================================================================
link_dotfiles() {
    log_section "Linking dotfiles"

    cd "$SCRIPT_DIR"
    local linked=0 skipped=0

    while IFS= read -r file; do
        local from="${SCRIPT_DIR}/${file}"
        local to="${HOME}${file#${DOTFILES_DIR}}"

        # Skip merged files
        if should_skip "$file"; then
            log_skip "$(basename "$file") (merged into .zshrc)"
            ((skipped++))
            continue
        fi

        # Create parent directory
        local dir=$(dirname "$to")
        [[ ! -d "$dir" ]] && mkdir -p "$dir"

        # Check if already correctly linked
        if [[ -L "$to" ]]; then
            local current=$(readlink "$to")
            if [[ "$current" == "$from" ]]; then
                log_skip "$(basename "$to") already linked"
                ((skipped++))
                continue
            fi
            rm "$to"
        fi

        # Backup existing file
        if [[ -f "$to" ]] || [[ -d "$to" ]]; then
            local backup="$to.bak.$(date +%Y%m%d_%H%M%S)"
            mv "$to" "$backup"
            log_warn "Backed up: $to"
        fi

        # Create symlink
        ln -s "$from" "$to"
        log_ok "Linked: $(basename "$to")"
        ((linked++))
    done < <(find "$DOTFILES_DIR" -type f 2>/dev/null)

    log_info "Linked: $linked, Skipped: $skipped"
}

unlink_dotfiles() {
    log_section "Unlinking dotfiles"

    cd "$SCRIPT_DIR"
    local unlinked=0

    while IFS= read -r file; do
        local from="${SCRIPT_DIR}/${file}"
        local to="${HOME}${file#${DOTFILES_DIR}}"

        should_skip "$file" && continue

        if [[ -L "$to" ]]; then
            local current=$(readlink "$to")
            if [[ "$current" == "$from" ]]; then
                rm "$to"
                log_ok "Unlinked: $(basename "$to")"
                ((unlinked++))

                # Restore backup if exists
                local backup=$(ls -t "${to}.bak."* 2>/dev/null | head -1)
                if [[ -n "$backup" && "${RESTORE:-false}" == "true" ]]; then
                    mv "$backup" "$to"
                    log_info "Restored: $backup"
                fi
            fi
        fi
    done < <(find "$DOTFILES_DIR" -type f 2>/dev/null)

    log_info "Unlinked: $unlinked files"
}

# =============================================================================
# Homebrew
# =============================================================================
install_homebrew() {
    log_section "Homebrew"

    if command -v brew &>/dev/null; then
        log_skip "Homebrew already installed"
        return
    fi

    log_info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add to path for current session
    if [[ -f "/opt/homebrew/bin/brew" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    log_ok "Homebrew installed"
}

install_brew_packages() {
    [[ ! -f "$SCRIPT_DIR/brew_packages.txt" ]] && return

    log_section "Homebrew packages"

    local to_install=()
    while read -r pkg; do
        [[ -z "$pkg" || "$pkg" =~ ^# ]] && continue
        if ! brew list "$pkg" &>/dev/null; then
            to_install+=("$pkg")
        else
            log_skip "$pkg"
        fi
    done < "$SCRIPT_DIR/brew_packages.txt"

    if [[ ${#to_install[@]} -gt 0 ]]; then
        log_info "Installing: ${to_install[*]}"
        brew install "${to_install[@]}"
        log_ok "Installed ${#to_install[@]} packages"
    else
        log_info "All packages already installed"
    fi
}

install_brew_casks() {
    is_macos || return
    [[ ! -f "$SCRIPT_DIR/brew_cask_packages.txt" ]] && return

    log_section "Homebrew casks"

    local to_install=()
    while read -r pkg; do
        [[ -z "$pkg" || "$pkg" =~ ^# ]] && continue
        if ! brew list --cask "$pkg" &>/dev/null; then
            to_install+=("$pkg")
        else
            log_skip "$pkg"
        fi
    done < "$SCRIPT_DIR/brew_cask_packages.txt"

    if [[ ${#to_install[@]} -gt 0 ]]; then
        log_info "Installing: ${to_install[*]}"
        brew install --cask "${to_install[@]}"
        log_ok "Installed ${#to_install[@]} casks"
    else
        log_info "All casks already installed"
    fi
}

# =============================================================================
# Oh-My-Zsh
# =============================================================================
install_oh_my_zsh() {
    log_section "Oh-My-Zsh"

    if [[ -d "$HOME/.oh-my-zsh" ]]; then
        log_skip "Oh-My-Zsh already installed"
        return
    fi

    log_info "Installing Oh-My-Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    log_ok "Oh-My-Zsh installed"
}

install_zsh_plugins() {
    log_section "ZSH plugins"

    local ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
    local plugins=(
        "zsh-users/zsh-autosuggestions"
        "zsh-users/zsh-history-substring-search"
        "zsh-users/zsh-syntax-highlighting"
        "zsh-users/zsh-completions"
    )

    for plugin in "${plugins[@]}"; do
        local name=$(basename "$plugin")
        local dest="$ZSH_CUSTOM/plugins/$name"

        if [[ -d "$dest" ]]; then
            log_skip "$name"
        else
            log_info "Installing $name..."
            git clone --depth=1 "https://github.com/$plugin" "$dest" &>/dev/null
            log_ok "$name installed"
        fi
    done
}

# =============================================================================
# NVM
# =============================================================================
install_nvm() {
    log_section "NVM (Node Version Manager)"

    local NVM_DIR="${NVM_DIR:-$HOME/development/nvm}"

    if [[ -s "$NVM_DIR/nvm.sh" ]]; then
        log_skip "NVM already installed"
        return
    fi

    log_info "Installing NVM..."
    mkdir -p "$NVM_DIR"
    PROFILE=/dev/null bash -c "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash" &>/dev/null

    # Load NVM and install Node
    export NVM_DIR
    source "$NVM_DIR/nvm.sh"

    log_info "Installing Node.js LTS..."
    nvm install --lts &>/dev/null
    nvm alias default 'lts/*' &>/dev/null
    log_ok "NVM and Node.js installed"
}

# =============================================================================
# Rust
# =============================================================================
install_rust() {
    log_section "Rust"

    if command -v rustup &>/dev/null; then
        log_skip "Rust already installed"
        return
    fi

    log_info "Installing Rust..."
    export CARGO_HOME="$HOME/development/cargo"
    export RUSTUP_HOME="$HOME/development/rustup"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path &>/dev/null
    source "$CARGO_HOME/env"
    log_ok "Rust installed"
}

install_rust_tools() {
    command -v cargo &>/dev/null || return

    log_section "Rust CLI tools"

    local tools=("bat" "eza" "fd-find" "ripgrep" "sd" "hyperfine" "gitui" "tokei")

    for tool in "${tools[@]}"; do
        if cargo install --list 2>/dev/null | grep -q "^$tool "; then
            log_skip "$tool"
        else
            log_info "Installing $tool..."
            cargo install "$tool" &>/dev/null
            log_ok "$tool installed"
        fi
    done
}

# =============================================================================
# Tmux & Vim
# =============================================================================
install_tmux_plugins() {
    log_section "Tmux Plugin Manager"

    local TPM="$HOME/.tmux/plugins/tpm"
    if [[ -d "$TPM" ]]; then
        log_skip "TPM already installed"
    else
        git clone --depth=1 https://github.com/tmux-plugins/tpm "$TPM" &>/dev/null
        log_ok "TPM installed (run prefix+I in tmux to install plugins)"
    fi
}

install_vim_plugins() {
    log_section "Vim plugins"

    local PLUG="$HOME/.vim/autoload/plug.vim"
    if [[ ! -f "$PLUG" ]]; then
        curl -fsSLo "$PLUG" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        log_ok "vim-plug installed"
    else
        log_skip "vim-plug already installed"
    fi

    # Install plugins silently
    command -v vim &>/dev/null && vim +PlugInstall +qall 2>/dev/null || true
    command -v nvim &>/dev/null && nvim +PlugInstall +qall 2>/dev/null || true
}

# =============================================================================
# macOS Specific
# =============================================================================
setup_macos() {
    is_macos || return

    log_section "macOS setup"

    # Rosetta 2 for Apple Silicon
    if is_arm && ! pgrep -q oahd 2>/dev/null; then
        log_info "Installing Rosetta 2..."
        sudo softwareupdate --install-rosetta --agree-to-license &>/dev/null || true
        log_ok "Rosetta 2 installed"
    else
        log_skip "Rosetta 2 (not needed or installed)"
    fi

    # Xcode license
    if xcode-select -p &>/dev/null; then
        sudo xcodebuild -license accept 2>/dev/null || true
    fi
}

# =============================================================================
# Status Check
# =============================================================================
show_status() {
    log_section "Installation Status"

    local checks=(
        "Homebrew:brew --version"
        "Oh-My-Zsh:test -d $HOME/.oh-my-zsh"
        "NVM:test -s $HOME/development/nvm/nvm.sh"
        "Rust:rustup --version"
        "Node:node --version"
        "TPM:test -d $HOME/.tmux/plugins/tpm"
    )

    for check in "${checks[@]}"; do
        local name="${check%%:*}"
        local cmd="${check#*:}"
        if eval "$cmd" &>/dev/null; then
            echo -e "  ${GREEN}[OK]${NC} $name"
        else
            echo -e "  ${RED}[--]${NC} $name"
        fi
    done
    echo ""
}

# =============================================================================
# Main
# =============================================================================
show_help() {
    cat << EOF
${BOLD}Usage:${NC} $0 [command] [options]

${BOLD}Commands:${NC}
  install     Full installation (default)
  link        Only link dotfiles
  unlink      Remove dotfile symlinks
  packages    Only install packages
  status      Show installation status
  help        Show this help

${BOLD}Options:${NC}
  --restore   When unlinking, restore backups
  --skip-brew Skip Homebrew packages

${BOLD}Examples:${NC}
  $0                    # Full install
  $0 link               # Just link dotfiles
  $0 unlink --restore   # Unlink and restore backups
  $0 packages           # Just install packages
  $0 status             # Check what's installed

EOF
}

main() {
    local cmd="${1:-install}"
    shift || true

    echo ""
    echo -e "${BOLD}${MAGENTA}"
    echo "  ╔═══════════════════════════════════════════════╗"
    echo "  ║           Dotfiles Installation               ║"
    echo "  ╚═══════════════════════════════════════════════╝"
    echo -e "${NC}"
    echo -e "  ${DIM}OS: $(uname -s) $(uname -m)${NC}"
    echo -e "  ${DIM}Source: $SCRIPT_DIR${NC}"
    echo ""

    case "$cmd" in
        install)
            setup_directories
            link_dotfiles
            setup_macos
            install_homebrew
            if [[ "${1:-}" != "--skip-brew" ]]; then
                install_brew_packages
                install_brew_casks
            fi
            install_oh_my_zsh
            install_zsh_plugins
            install_nvm
            install_rust
            install_rust_tools
            install_tmux_plugins
            install_vim_plugins
            show_status

            echo -e "${GREEN}${BOLD}Installation complete!${NC}"
            echo ""
            echo "Next steps:"
            echo "  1. Restart your terminal or run: source ~/.zshrc"
            echo "  2. Create ~/.zshrc.local for machine-specific config"
            echo "  3. In tmux, press prefix+I to install plugins"
            echo ""
            ;;
        link)
            setup_directories
            link_dotfiles
            ;;
        unlink)
            [[ "${1:-}" == "--restore" ]] && export RESTORE=true
            unlink_dotfiles
            ;;
        packages)
            setup_macos
            install_homebrew
            install_brew_packages
            install_brew_casks
            install_oh_my_zsh
            install_zsh_plugins
            install_nvm
            install_rust
            install_rust_tools
            install_tmux_plugins
            install_vim_plugins
            ;;
        status)
            show_status
            ;;
        help|--help|-h)
            show_help
            ;;
        *)
            log_error "Unknown command: $cmd"
            show_help
            exit 1
            ;;
    esac
}

main "$@"
