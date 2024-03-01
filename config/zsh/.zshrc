### ------- SOURCE -------- ### 
source "$ZDOTDIR/aliases"
source "$ZDOTDIR/functions"/*

### ------- EXPORT -------- ### 
export GOPATH="$HOME/.local/go"
export GEM_PATH="$HOME/.gem"
export BUN_INSTALL="$HOME/.bun"

export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME="robbyrussell"

# If you come from bash you might have to change your $PATH
export PATH=$PATH:$HOME/bin:/usr/local/bin:$HOME/.local/bin:$BUN_INSTALL/bin:$GEM_PATH/bin/:$GOPATH/bin

### ------ OH MY ZSH ------- ### [REMOVE IF YOU DONT WANT OH-MY-ZSH]
if [[ -f /$ZSH/oh-my-zsh.sh ]]; then
        zstyle ':omz:update' mode reminder  # just remind me to update when it's time

        plugins=(git)

        source $ZSH/oh-my-zsh.sh
else 
        echo "You dont have oh-my-zsh installed"
        read REPLY\?"---- Do you wanna install oh-my-zsh? (y/n)"

        if [ "${REPLY}" = "y" ] || [ "${REPLY}" = "Y" ]; then
                git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
        else
                echo "-------- Remove this script from '~/.dotfiles/config/zsh/.zshrc' to not ask again"
        fi
fi
