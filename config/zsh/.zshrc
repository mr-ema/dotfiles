### ------- SOURCE -------- ### 
source "$ZDOTDIR/aliases"
source "$ZDOTDIR/functions"/*
source "$ZDOTDIR/.antidote/antidote.zsh"

# Conditional source
(( $+commands[fzf] )) && source <(fzf --zsh)

# If you come from bash you might have to change your $PATH
export PATH=$PATH:$HOME/.bin:$HOME/bin:/usr/local/bin:$HOME/.local/bin

### ------- Settings -------- ### 
HISTFILE="$ZDOTDIR/.zsh_history"

## ------- Bindings ------- ##
bindkey "^E" end-of-line

### ------- Init ------- ###
antidote load

(( $+commands[oh-my-posh] )) && eval "$(oh-my-posh init zsh --config ~/.dotfiles/oh-my-posh/themes/tokyonight_storm.omp.json)"
