typeset -U PATH path

export EDITOR=nvim

export ZDOTDIR="$HOME/.config/zsh"

# XDG paths
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}

export LESSHISTFILE=-

# If you come from bash you might have to change your $PATH
export PATH=$PATH:$HOME/.bin:$HOME/bin:/usr/local/bin:$HOME/.local/bin
