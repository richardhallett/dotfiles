# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Settings
source ~/.bash/settings.bash

source ~/.bash/prompt.bash

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
