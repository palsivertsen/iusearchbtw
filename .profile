# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022


# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

########
## Go ##
########
export PATH=$PATH:$(go env GOPATH)/bin

# Wallpaper
#j=$(curl "http://www.splashbase.co/api/v1/images/random?images_only=true")
#large=$(echo "$j" | jq -r ".large_url")
#url=$(echo "$j" | jq -r ".url")
#feh --bg-center "$large" || feh --bg-center "$url"

# Screensaver
xset s 1800 300

###########
# flutter #
###########
export CHROME_EXECUTABLE=google-chrome-stable
export PATH=$PATH:~/development/flutter/bin
if [ -n "$BASH_VERSION" ] -a ! hash flutter >/dev/null 2>&1; then
	flutter bash-completion > ~/.bash_completion.d/flutter.sh
fi

tabs -2

#######
# XDG #
#######
export XDG_DATA_DIRS=/usr/share:/usr/local/share

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi
