echo 'rbenv...'
eval "$(rbenv init -)"
rbenv global 2.3.0

echo 'nvm...'
. "/usr/local/opt/nvm/nvm.sh"
nvm use --silent stable
