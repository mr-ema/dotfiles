### ------- SOURCE -------- ### 
source "$ZDOTDIR/aliases"
source "$ZDOTDIR/functions"/*
source "$ZDOTDIR/.antidote/antidote.zsh"

# Conditional source
(( $+commands[fzf] )) && source <(fzf --zsh)

export BUN_INSTALL="$HOME/.bun"
# If you come from bash you might have to change your $PATH
export PATH=$PATH:$HOME/.bin:$HOME/bin:/usr/local/bin:$HOME/.local/bin:$HOME/.local/share/gem/ruby/3.1.0/bin:$BUN_INSTALL/bin

### ------- Settings -------- ### 
HISTFILE="$ZDOTDIR/.zsh_history"

## ------- Bindings ------- ##
bindkey "^E" end-of-line

## ------- Catch Commands ------- ##
preexec() {
    local cmd
    cmd="$1"

    # Mejor prevenir que lamentar
    if [[ "$cmd" == "rm -rf *" || "$cmd" == "rm -rf ~" || "$cmd" == "rm -rf /" ]]; then
        vared -p "[DANGER] Are you 69 porcent sure you want to execute '$cmd'? [y/n] " -c response
        if [[ "$response" != "y" && "$response" != "yes" ]]; then
                exec zsh
        fi
    fi
}

### ------- Init ------- ###
antidote load
autoload -Uz add-zsh-hook
add-zsh-hook preexec preexec

(( $+commands[oh-my-posh] )) && eval "$(oh-my-posh init zsh --config ~/.dotfiles/oh-my-posh/themes/tokyonight_storm.omp.json)"

# bun completions
[ -s "/home/tammuz/.bun/_bun" ] && source "/home/tammuz/.bun/_bun"
