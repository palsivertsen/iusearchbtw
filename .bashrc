# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export EDITOR=nvim

###########
# History #
###########
# Keep this many lines from each session
HISTSIZE=5000
# Store at most this many lines
HISTFILESIZE=100000
# Ignore lines starting with a space
HISTCONTROL=ignorespace:erasedups
# Append to the history file, don't overwrite it
shopt -s histappend
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

###########
# Aliases #
###########
for f in ~/.bash_aliases.d/*; do
	if [[ $f == @(*.bash|*.sh) ]]; then
		source $f
	fi
done

################
# Bash scripts #
################
for f in ~/.bash_scripts.d/*; do
	if [[ $f == @(*.bash|*.sh) ]]; then
		source $f
	fi
done


###################
# Bash completion #
###################
for f in ~/.bash_completion.d/*; do
	if [[ $f == @(*.bash|*.sh) ]]; then
		source $f
	fi
done

#######
# git #
#######
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto verbose"
GIT_PS1_DESCRIBE_STYLE="branch"
GIT_PS1_SHOWCOLORHINTS=1

if [ -f /usr/share/git/completion/git-prompt.sh ]; then source /usr/share/git/completion/git-prompt.sh; fi

# AWS status
awsstatus() {
	if [ -v AWS_PROFILE ]; then
		echo ' \[$(tput sgr0)\](\[$(tput setaf 3)\]aws:$AWS_PROFILE\[$(tput sgr0)\])'
	fi
}

# Change PS1
# See:
# https://wiki.archlinux.org/index.php/Color_Bash_Prompt

COLOR_RED="\[$(tput setaf 1)\]"
COLOR_GREEN="\[$(tput setaf 2)\]"
COLOR_YELLOW="\[$(tput setaf 3)\]"
COLOR_CYAN="\[$(tput setaf 6)\]"
COLOR_RESET="\[$(tput sgr0)\]"
buildPS1()
{
	local EXIT=$?
	local COLOR_CALC_EXIT=$(if [ $EXIT == "0" ]; then echo -n $COLOR_GREEN; else echo -n $COLOR_RED; fi)
	local EXIT_STATUS="$COLOR_CALC_EXIT$EXIT"
	local CURRENT_TIME="$COLOR_CYAN\t"
	local USER_NAME="$COLOR_YELLOW\u"
	local WORKING_DIR="$COLOR_CALC_EXIT\w"
	echo -n "$EXIT_STATUS $CURRENT_TIME $USER_NAME $WORKING_DIR$(awsstatus)$COLOR_RESET"
}

export PROMPT_COMMAND='__git_ps1 "$(buildPS1)" "\n$COLOR_RESET$ "'

#######
# fzf #
#######
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash
export KUBECTX_IGNORE_FZF=1

######
# jq #
######
export JQ_COLORS="1;37:0;31:0;32:0;39:0;33:1;39:1;39"

########
# Dart #
########
export PATH="$PATH":"$HOME/.pub-cache/bin"


# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION

#######
# npm #
#######
export npm_config_prefix="$HOME/.local"

##########
# GitLab #
##########
[[ -n $(pathchk lab) ]] && source <(lab completion)

########
# Less #
########
export LESS="--incsearch"
