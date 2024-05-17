
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

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload -Uz promptinit && promptinit && prompt powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source "$HOME/.config/zsh/.p10k.zsh"
