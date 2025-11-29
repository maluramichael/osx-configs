local user='%{$fg[magenta]%}%h%{$reset_color%}'
PROMPT=$(echo -e "[$USER@$HOST][%F{green}%6c%F{blue}]")

if [ -n "$VIRTUAL_ENV" ]; then
  VENV_NAME=$(basename "$VIRTUAL_ENV")
  PROMPT+=$(echo -e "[%{$fg[green]%}$VENV_NAME%{$reset_color%}]")
fi

PROMPT+=$(echo -e "\n$%f ")
