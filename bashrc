# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Settings
source ~/.bash/settings.bash

source ~/.bash/prompt.bash

## Local files not in git
source ~/

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -f ~/.bashrc_local ]; then
    source ~/.bashrc_local
fi