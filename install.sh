#!/bin/sh

# Variables ------------------------------------------------------------------
# dir where your dots files live
dir=~/.dotfiles
# files that goes in $HOME
home_files=(".zshenv" ".gitconfig")
# files that goes in $HOME/.config
config_dirs=("zsh" "nvim" "kitty")
 # dirs that goes in $HOME and are dot dirs. ex: '.bash, .fonts'
home_dirs=("fonts")

# Syminator ------------------------------------------------------------------
# 1. from: argument shoud be the source file
# 2. to:   argument shoud be the target dir to create a SymLink
# 3. dot:  argument shoud be empty string or a dot '.'
# The dot argument is in case that the target dir need to have a dot but the source file dont have one.
function Syminator() {
        local from="${1}"
        local to="${2}"
        local dot="${3}"
        shift 3         # Shift x arguments to the left
        arr=("$@")

        for file in "${arr[@]}"; do
                if [ -L "$to/${dot}${file}" ]; then
                        printf "\t\e[1;36m%s\e[m\n" "[L] Link $to/${dot}${file} already exists"
                elif [ -d "$to/${dot}${file}" ] || [ -f "$to/${dot}${file}" ]; then
                        printf "\t\e[1;33m%s\e[m\n" "[F] File $to/${dot}${file} already exists"
                else
                        ln -sv "$from/$file" "$to/${dot}${file}"
                fi
        done
}

# Setup SymLinks ------------------------------------------------------------
echo " Step [1] - Create Symbolic Links -----------------------------"
# Syminator $sorce_dir $target_dir $dot[""|"."] $array_files_names
Syminator "$dir" "$HOME" "" "${home_files[@]}" 
Syminator "$dir" "$HOME" "." "${home_dirs[@]}"
Syminator "$dir/config" "$HOME/.config" "" "${config_dirs[@]}" 


echo -e "\n Done"
