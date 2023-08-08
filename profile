export QT_QPA_PLATFORMTHEME="qt5ct"
export EDITOR=/usr/bin/nvim
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export BROWSER=/usr/bin/firefox
export GODOT4=$HOME/.local/bin/godot
export TERMINAL=alacritty
export BAT_THEME="gruvbox-light"
export SHELL=/bin/fish

if [ -d "$HOME/.local/bin" ] && (! echo $PATH | grep -q "$HOME/.local/bin"); then
    export PATH="$HOME/.local/bin:$PATH"
fi