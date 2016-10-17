# make a dir and cd into it
mcd () {
    mkdir -p "$@" && cd "$@"
}

exip () {
    # gather external ip address
    echo -n "Current External IP: "
    curl -s -m 5 http://myip.dk | grep "ha4" | sed -e 's/.*ha4">//g' -e 's/<\/span>.*//g'
}

# determine local IP address
ips () { ifconfig | grep "inet " | awk '{ print $2 }' | grep -v '127.0.0.1'}

ghget () {
    # input: rails/rails
    USER=$(echo $@ | tr "/" " " | awk '{print $3}')
    REPO=$(echo $@ | tr "/" " " | awk '{print $4}')
	echo $USER
	echo $REPO
    # mkdir -p "$DEV_HOME/github.com/$USER"
    # git clone $@
    # cd $REPO
}

nicemount() { (echo "DEVICE PATH TYPE FLAGS" && mount | awk '$2="";1') | column -t ; }
