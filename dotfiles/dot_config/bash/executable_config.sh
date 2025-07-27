
# Set bash history file location
history_dir="$HOME/.local/share/bash/"
mkdir -p "$history_dir"
export HISTFILE="$history_dir/.bash_history"

# don't put duplicate lines or lines starting with space in the history.
# see bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'

# where user specific configurations should be written (analogous to /etc)
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:=$HOME/.config}"
# where user specific data files should be written (analogous to /usr/share)
export XDG_DATA_HOME="${XDG_DATA_HOME:=$HOME/.local/share}"
# where user specific non-essential (cached) data should be written (analogous to /var/cache)
export XDG_CACHE_HOME="${XDG_CACHE_HOME:=$HOME/.local/cache}"
# where user specific state files should be written (analogous to /var/lib)
export XDG_STATE_HOME="${XDG_STATE_HOME:=$HOME/.local/state}"

if [ -f "$XDG_CONFIG_HOME/user-dirs.dirs" ]; then
    source "$XDG_CONFIG_HOME/user-dirs.dirs"
fi
