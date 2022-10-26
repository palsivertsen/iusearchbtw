# If not running interactively, don't do anything
[[ $- != *i* ]] && return

EDITOR=vim

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

# Set terminal tab width
tabs -4

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
complete -C /usr/bin/aws_completer aws
source <(yq shell-completion bash)

#######
# git #
#######
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto verbose"
GIT_PS1_DESCRIBE_STYLE="branch"
GIT_PS1_SHOWCOLORHINTS=1

# Change PS1
# See:
# https://wiki.archlinux.org/index.php/Color_Bash_Prompt

PS1_EXIT_STATUS_OK="\[$(tput setaf 2)\]"
PS1_EXIT_STATUS_ERROR="\[$(tput setaf 1)\]"
PS1_EXIT_STATUS="\$(EXIT=\$?; if [[ \$EXIT == 0 ]]; then echo \"$PS1_EXIT_STATUS_OK\"; else echo \"$PS1_EXIT_STATUS_ERROR\"; fi; echo \$EXIT)"
PS1_CURRENT_TIME="\[$(tput setaf 6)\]\t"
PS1_USER_NAME="\[$(tput setaf 3)\]\u"
PS1_WORKING_DIR="\[$(tput setaf 2)\]\w"
export PROMPT_COMMAND='__git_ps1 "$PS1_EXIT_STATUS $PS1_CURRENT_TIME $PS1_USER_NAME $PS1_WORKING_DIR\[\033[0m\]" "\n$ \[$(tput sgr0)\]"'

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


####################
# Google app creds #
####################
export GOOGLE_APPLICATION_CREDENTIALS="/home/pal/.firebase/ps-prod-6f2d8-firebase-adminsdk-v0tf0-5440e4cbf8.json"

#######
# npm #
#######
export npm_config_prefix="$HOME/.local"

##########
# GitLab #
##########
source <(lab completion)
