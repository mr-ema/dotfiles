###------- SOURCE --------### 
source "$HOME/.env"
source "$ZDOTDIR/aliases"
source "$ZDOTDIR/functions"/*

# if you come from bash you might have to change your $PATH
export PATH=$HOME/bin:/usr/local/bin:$CUSTOM_PATH:$PATH 

###------OH-MY-ZSH-------###
# REMOVE IF YOU DONT WANT OH-MY-ZSH
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
