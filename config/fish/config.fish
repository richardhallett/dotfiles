set --export EDITOR nvim

# disable greeting
set fish_greeting

# Export local bin folders to path
fish_add_path --move $HOME/bin
fish_add_path --move $HOME/.local/bin

# Setup language specific path vars
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/go/bin
fish_add_path $HOME/.rbenv/bin
fish_add_path $HOME/n/bin
fish_add_path $HOME/.cargo/bin/
fish_add_path /usr/share/dotnet/
fish_add_path $HOME/.nix-profile/bin/
fish_add_path /usr/lib/emscripten
fish_add_path /home/rph/.nimble/bin

# Aliases
alias ll 'exa --tree --level=2 -a --long --header --accessed'

# Env variables
# Opt out of .net telemetry
set -x DOTNET_CLI_TELEMETRY_OPTOUT 1
set -x CHEAT_USE_FZF true

# Starship setup
starship init fish | source

# Load rbenv into shell automatically
if command -s rbenv > /dev/null
    status --is-interactive; and rbenv init - fish | source
end
