#set --export EDITOR nvim

# disable greeting
set fish_greeting

# Export local bin folder to path
fish_add_path --move $HOME/bin

# Setup language specific path vars
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/go/bin
fish_add_path $HOME/.rbenv/bin
