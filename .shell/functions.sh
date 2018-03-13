# determine local IP address
ips () { ifconfig | grep "inet " | awk '{ print $2 }' | grep -v '127.0.0.1'}
