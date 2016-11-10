# osx-configs
My ~ configurations for osx

# Getting started

First install all packages
```sh
sh install_packages.sh
```

Then link configurations in to your home directory
```sh
sh link.sh
```

**Set your github token inside the setup_osx_preferences.sh file** and run
```sh
sh setup_osx_preferences.sh
```

Done


# Docker

# create the docker machine
```sh
docker-machine create --driver "virtualbox" default
```

# start the docker machine
```sh
docker-machine start
```

# this command allows the docker commands to be used in the terminal
```sh
eval "$(docker-machine env)"
```

# at this point can run any "docker" or "docker-compose" commands you want
```sh
docker-compose up
```
