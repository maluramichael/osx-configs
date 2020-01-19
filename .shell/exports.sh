export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/local/bin:/opt/local/sbin"

export LANG=en_US.UTF-8
export DEV_HOME="$HOME/development"
export REACT_EDITOR=code
export NVM_DIR="$HOME/.nvm"

# android
#export ANDROID_HOME="$HOME/Library/Android/sdk"
#export ANDROID_BUILD_TOOLS="$ANDROID_HOME/build-tools/$(ls -t $ANDROID_HOME/build-tools | tail -1)"
#export ANDROID_KEYSTORES="$DEV_HOME/keystores"
#export PATH="$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools:$ANDROID_BUILD_TOOLS"

# virtualenv
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/development/projects
export VIRTUALENVWRAPPER_PYTHON="/opt/local/bin/python"

export LATEX_HOME="/Library/TeX/texbin"

export CARGO_HOME="$HOME/.cargo"

if [ -f ~/.credentials.sh ]; then
    source ~/.credentials.sh
fi

export PATH="$HOME/Library/Python/3.7/bin:$PATH"
export PATH="$CARGO_HOME/bin:$LATEX_HOME:$PATH"
