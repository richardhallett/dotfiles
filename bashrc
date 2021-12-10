# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Settings
source ~/.bash/settings.bash

source ~/.bash/prompt.bash

## Local files not in git
#source ~/

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -f ~/.bashrc_local ]; then
    source ~/.bashrc_local
fi

# Export local bin folder to path
export PATH="$HOME/bin:$PATH"

# If rbenv is install then run init for shell
if [ -f $HOME/.rbenv/bin/rbenv ]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
    export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
fi

# If cargo env file is install then source it
if [ -f $HOME/.cargo/env ]; then
    . "$HOME/.cargo/env"
fi

# If N(Node package manager) installed, then run it's includes
if [ -f $HOME/n/bin/n ]; then
    export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"
fi

# Docker CE exports
export DOCKER_HOST=unix:///run/user/1000/docker.sock