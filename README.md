# osx-configs

Personal dotfiles and development environment configuration for macOS.

## Features

- Single consolidated `.zshrc` with organized sections
- Lazy-loaded NVM for fast shell startup
- Idempotent install script (safe to run multiple times)
- Tokyo Night themed tmux with git status integration
- Modern CLI tool support (eza, fd, ripgrep, bat)

## Quick Start

```sh
git clone git@github.com:maluramichael/osx-configs.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

## Install Commands

| Command | Description |
|---------|-------------|
| `./install.sh` | Full installation (directories, dotfiles, packages) |
| `./install.sh link` | Only create symlinks |
| `./install.sh unlink` | Remove symlinks |
| `./install.sh unlink --restore` | Remove symlinks and restore backups |
| `./install.sh packages` | Only install packages |
| `./install.sh status` | Show installation status |
| `./install.sh --skip-brew` | Skip Homebrew packages |

## What Gets Installed

### Dotfiles
- `.zshrc` - ZSH configuration (aliases, functions, exports combined)
- `.tmux.conf` - Tmux configuration with plugins
- `.vimrc` / `.config/nvim/init.vim` - Vim/Neovim configuration
- `.gitconfig` - Git configuration
- `.gitmux.conf` - Gitmux theme for tmux status bar

### Tools
- Homebrew packages (see `brew_packages.txt`)
- Homebrew casks (see `brew_cask_packages.txt`)
- Oh-My-Zsh with plugins
- NVM (Node Version Manager)
- Rust toolchain and CLI tools
- Tmux Plugin Manager (TPM)

## Tmux Keybindings

### Windows
| Key | Action |
|-----|--------|
| `Alt+c` | New window |
| `Alt+w` | Kill window |
| `Alt+n/p` | Next/previous window |
| `Alt+0-9` | Select window by number |
| `Alt+,` | Rename window |
| `Alt+Tab` | Last window |
| `Alt+</>` | Swap window left/right |

### Panes
| Key | Action |
|-----|--------|
| `Alt+[` | Split horizontal |
| `Alt+]` | Split vertical |
| `Alt+hjkl` | Navigate panes |
| `Alt+HJKL` | Resize panes |
| `Alt+x` | Kill pane |
| `Alt+z` | Zoom pane |

### Sessions
| Key | Action |
|-----|--------|
| `Alt+s` | Choose session |
| `Alt+S` | New session |
| `Alt+$` | Rename session |
| `Alt+d` | Detach |
| `Alt+\` | Last session |

### Plugins
| Key | Action |
|-----|--------|
| `prefix` | Show which-key menu |
| `prefix+e` | Extrakto (copy from scrollback) |
| `prefix+F` | Thumbs (quick copy hints) |
| `prefix+f` | Tmux-fzf |
| `prefix+u` | Open URLs |

## ZSH Functions

| Function | Description |
|----------|-------------|
| `mcd <dir>` | Create directory and cd into it |
| `extract <file>` | Extract any archive format |
| `ff <pattern>` | Find files by name |
| `dev` / `work` / `proj` | Quick directory navigation |
| `changejava <version>` | Switch Java version |
| `runtests` | Auto-detect and run project tests |
| `sf <cmd>` | Symfony console shortcut |
| `docker-cleanup` | Stop and remove all containers |
| `myip` | Show public IP |
| `ips` | Show local IPs |

## Local Overrides

Create `~/.zshrc.local` for machine-specific configuration that won't be committed.

## Directory Structure

```
~/
├── development/
│   ├── projects/
│   ├── lulububu/
│   ├── libs/
│   ├── nvm/
│   ├── go/
│   ├── cargo/
│   └── rustup/
└── tools/
```

## Post-Installation

1. Restart terminal or run `source ~/.zshrc`
2. In tmux, press `prefix+I` to install plugins
3. In vim/nvim, run `:PlugInstall`
