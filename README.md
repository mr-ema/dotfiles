# DotFiles
These are my `.Files`. Feel free to take whatever you want.

</br>

## Quick Navigation
- [Resources](https://github.com/mr-ema/dotfiles#resources)
- [Install](https://github.com/mr-ema/dotfiles#resources)
- [Use Of Install Script](https://github.com/mr-ema/dotfiles#use-of-install-script)

</br>

## Resources
- [Awesome Dotfiles](https://github.com/webpro/awesome-dotfiles)
- [SE-EDU](https://se-education.org/learningresources/contents/dotfiles/Dotfiles.html)

</br>
</br>

## Install

</br>

> **Note**
> For this script to work you must manually remove the folders and files required by the script.

</br>

First clone the repository
```
git clone https://github.com/mr-ema/dotfiles ~/.dotfiles
```
Then run
```
cd ~/.dotfiles && ./install.sh
```

</br>
</br>

## Use Of Install Script

### Variables
- `config_files`: An array with the name of your configuration files.
- `home_files`: The configuration files that should go in your `$HOME` directory. `For example .bashrc`
- `home_dirs`: Dirs that have a dot and goes in $HOME like `.bash .fonts`

```bash
# Variables - (Array Variables Has To Be Separated By A Space)

dir=~/.dotfiles                         # dir where your dots files live
home_files=".zshenv .gitconfig"         # files that goes in $HOME
config_files="zsh nvim kitty"           # files that goes in $HOME/.config
home_dirs="fonts"                       # dirs that goes in $HOME and are dot dirs. ex: '.bash, .fonts'
```

</br>

### Sym Links
This part of the script create [symbolic links](https://www.futurelearn.com/info/courses/linux-for-bioinformatics/0/steps/201767)
to `~/.config` and `~/` linking the configuration files inside `.dotfiles`

```bash
# Syminator ------------------------------------------------------------------
# 1. from: argument shoud be the source file
# 2. to:   argument shoud be the target dir to create a SymLink
# 3. dot:  argument shoud be empty string or a dot '.'
# The dot argument is in case that the target dir need to have a dot but the source file dont have one.
function Syminator() {
        from="${1}"
        to="${2}"
        dot="${3}"

        for file in ${4}; do
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
Syminator "$dir" "$HOME" "" "${home_files}" 
Syminator "$dir" "$HOME" "." "${home_dirs}"
Syminator "$dir/config" "$HOME/.config" "" "${config_dirs}" 

echo " Done"
```
