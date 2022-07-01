append_envvar XDG_DATA_DIR '/usr/share'
append_envvar XDG_DATA_DIR '/usr/local/share'
export XDG_DATA_DIRS
append_envvar XDG_CONFIG_DIR '/etc/xdg'
export XDG_CONFIG_DIRS

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
mkdir -p "$XDG_CONFIG_HOME" "$XDG_CACHE_HOME" "$XDG_DATA_HOME" "$XDG_STATE_HOME"

if [ -e "$XDG_CONFIG_HOME/user-dirs.dirs" ]
then
    source "$XDG_CONFIG_HOME/user-dirs.dirs"
fi
