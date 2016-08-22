export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="foo-clean"
COMPLETION_WAITING_DOTS="true"
plugins=(git brew symfony2 virtualenv)
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

echo 'load oh-my-zsh.sh'
source $ZSH/oh-my-zsh.sh
source /usr/local/share/zsh/site-functions/_aws

source ~/.shell/exports.sh
source ~/.shell/alias.sh
source ~/.shell/functions.sh
source ~/.shell/setup.sh

#source /usr/local/bin/virtualenvwrapper.sh
