# custom $PATH. if not needed remove it from here and the line below
CUSTOM_PATH=$HOME/.local/bin
# if you come from bash you might have to change your $PATH
export PATH=$HOME/bin:/usr/local/bin:$CUSTOM_PATH:$PATH 


###------- SOURCE --------### 
source ~/.config/zsh/aliases
source ~/.config/zsh/functions/*


###------- EXPORT --------###
export ZSH="$HOME/.oh-my-zsh"
export GOPATH="$HOME/.local/go"


###------OH-MY-ZSH-------###
# REMOVE IF YOU DONT WANT OH-MY-ZSH
if [[ -f /$ZSH/oh-my-zsh.sh ]]; then

        ZSH_THEME="robbyrussell"
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
