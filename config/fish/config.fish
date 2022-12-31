#set --export EDITOR nvim

# disable greeting
set fish_greeting

# Export local bin folders to path
fish_add_path --move $HOME/bin
fish_add_path --move $HOME/.local/bin

# Setup language specific path vars
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/go/bin
fish_add_path $HOME/.rbenv/bin

# Aliases
alias ll 'exa --tree --level=2 -a --long --header --accessed'