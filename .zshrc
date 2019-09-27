export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="alanpeabody"
COMPLETION_WAITING_DOTS="true"
plugins=(
 git
 docker
 debian
 zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting zsh-completions
)
autoload -U compinit && compinit

source $ZSH/oh-my-zsh.sh

source ~/.shell/exports.sh
source ~/.shell/alias.sh
source ~/.shell/functions.sh
source ~/.shell/setup.sh
source ~/.profile

echo 'current ip:' $(ips)
