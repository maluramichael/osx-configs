# osx-configs
My ~ configurations for osx

# Prequesits
Install the latested xcode version from the app store

# Getting started

First install all packages.
```sh
sh install_packages.sh
```

Then link configurations in to your home directory.
```sh
sh link.sh
exit
```

Reopen the terminal.

Some stuff needs the environment to be linked.
```sh
sh after_link.sh
```

**Set your github token inside the setup_osx_preferences.sh file** and run
```sh
sh setup_osx_preferences.sh
```

Done
