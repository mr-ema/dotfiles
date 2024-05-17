### ------- SOURCE -------- ### 
source "$ZDOTDIR/aliases"
source "$ZDOTDIR/functions"/*
source "$ZDOTDIR/.antidote/antidote.zsh"

### ------- EXPORT -------- ### 
export GOPATH="$HOME/.local/go"
export GEM_PATH="$HOME/.gem"
export BUN_INSTALL="$HOME/.bun"

# If you come from bash you might have to change your $PATH
export PATH=$PATH:$HOME/bin:/usr/local/bin:$HOME/.local/bin:$BUN_INSTALL/bin:$GEM_PATH/bin/:$GOPATH/bin

### ------- Init ------- ###
antidote load

### ------- Scripts ------- ###
