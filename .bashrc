# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# don't put duplicate lines or lines starting with space in the history.
# Erase duplicates to keep file minimal
# See bash(1) for more options
HISTCONTROL=ignoreboth:erasedups
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

HISTSIZE=5000
HISTFILESIZE=10000

# append to the history file, don't overwrite it
shopt -s histappend
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Set terminal tab width
tabs -4

###########
# Aliases #
###########
if [ -d ~/.bash_aliases.d/ ]; then
    . ~/.bash_aliases.d/*.bash
fi

#######
# git #
#######
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto verbose"

# Change PS1
# See:
# https://wiki.archlinux.org/index.php/Color_Bash_Prompt

PS1_EXIT_STATUS_OK="\[$(tput setaf 2)\]"
PS1_EXIT_STATUS_ERROR="\[$(tput setaf 1)\]"
PS1_EXIT_STATUS="\$(EXIT=\$?; if [[ \$EXIT == 0 ]]; then echo \"$PS1_EXIT_STATUS_OK\"; else echo \"$PS1_EXIT_STATUS_ERROR\"; fi; echo \$EXIT)"
PS1_CURRENT_TIME="\[$(tput setaf 6)\]\t"
PS1_USER_NAME="\[$(tput setaf 3)\]\u"
PS1_WORKING_DIR="\[$(tput setaf 2)\]\w"
export PROMPT_COMMAND='__git_ps1 "\n$PS1_EXIT_STATUS $PS1_CURRENT_TIME $PS1_USER_NAME $PS1_WORKING_DIR\[\033[0m\]" "\n$ \[$(tput sgr0)\]"'
