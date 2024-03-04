# Zsh Dark Sorcery
Unveil the arcane powers of Zsh dark sorcery setup. Delve into
the abyss of command-line mastery as we harness the shadows to customize
and enhance your terminal experience. Enter the realm of Zsh Dark Sorcery
and awaken the magic within your shell. (_AI Generated_)

</br>

## Navigation

- [Getting Started](#getting-started)
- [Aliases](#aliases)
- [Functions](#functions)
- [Useful Links](#useful-links)

</br>
</br>

## Useful Links

- [Shell Scripting _Tutorial_](https://www.tutorialspoint.com/unix/shell_scripting.htm)
- [Classic Shell Scripting _Book_](https://www.amazon.com/Classic-Shell-Scripting-Arnold-Robbins/dp/0596005954)
- [Zsh Cheatsheet](https://devhints.io/zsh)

</br>
</br>

## Getting Started

1. One important thing to remember, if you're not using the
`.dotfile` installer, is that you will need to create a `.zshenv` file in
`$HOME` with the code below in order to get this configuration to work.

2. After completing the previus step, you are ready to edit the `.zshrc`. In
case you haven't installed Nim and cargo, remove them from the
`CUSTOM_PATH` variable. Additionally, if you don't want to install oh-my-zsh, you
should remove it from the script.

</br>

```zsh
# ~/.zshenv

typeset -U PATH path

# source $HOME/.config/.zshrc

export ZDOTDIR="$HOME/.config/zsh"
export HISTFILE="$HOME/.config/zsh/.zsh_history"

# XDG paths
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}

export LESSHISTFILE=-

```

</br>

```zsh
# ~/.config/.zshrc

###--------- PATH --------###
CUSTOM_PATH=$HOME/.cargo/bin:$HOME/.nimble/bin          # custom $PATH. if not needed remove it from here and the line below
export PATH=$HOME/bin:/usr/local/bin:$CUSTOM_PATH:$PATH # if you come from bash you might have to change your $PATH


###------- SOURCE --------### 
source ~/.config/zsh/aliases
source ~/.config/zsh/functions/*


###------- EXPORT --------###
export ZSH="$HOME/.oh-my-zsh" # REMOVE IF YOU DONT WANT OH-MY-ZSH
export GOPATH="$HOME/Desktop/code/go"


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
```

</br>
</br>

## Aliases

**An alias in Bash (and most shells) is a way to run a
long command using a short one.** If you repeat a command
often in the terminal, an alias can save you a lot of
typing. [_More_](https://phoenixnap.com/kb/linux-alias-command)

</br>

An example is when you want to conenct to a specific bluetooth device via terminal you have to type:
```
bluetoothctl connect 30:53:C1:33:99:7B
``` 

</br>

Let's create an alias for the previus command. to create an alias use the following syntax (note that there is not space beetween `=`)
```
alias [name]='[command]'
```

</br>

If we Followed the syntax correctly. The previus command would look something like this:
```
alias headset="bluetoothctl connect 30:53:C1:33:99:7B"
```

</br>

Now after save the alias in the `aliases` file and restart the terminal we can type
`headset` and it will run `bluetoothctl connect 30:53:C1:33:99:7B`.

</br>
</br>

## Functions

Shell functions are a way to group commands for later execution using a single name for the group. They are executed just like a "regular" command. When the name of a shell function is used as a simple command name, the list of commands associated with that function name is executed. Shell functions are executed in the current shell context; no new process is created to interpret them. [_More_](https://www.gnu.org/software/bash/manual/html_node/Shell-Functions.html)


Example: A Function To Extract Common Files Formats. [[_source_]](https://github.com/xvoland/Extract/blob/master/extract.sh)

```zsh
#!/bin/bash
# function Extract for common file formats

SAVEIFS=$IFS
IFS="$(printf '\n\t')"

function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz|.zlib|.cso>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
 else
    for n in "$@"
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.cbr|*.rar) unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.cbz|*.epub|*.zip) unzip ./"$n"   ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.apk|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *.cpio)      cpio -id < ./"$n"  ;;
            *.cba|*.ace) unace x ./"$n"     ;;
            *.zpaq)      zpaq x ./"$n"      ;;
            *.arc)       arc e ./"$n"       ;;
            *.cso)       ciso 0 ./"$n" ./"$n.iso" && \
                              extract "$n.iso" && \rm -f "$n" ;;
            *.zlib)      zlib-flate -uncompress < ./"$n" > ./"$n.tmp" && \
                              mv ./"$n.tmp" ./"${n%.*zlib}" && rm -f "$n"   ;;
            *)
                         echo "extract: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file doesn't exist"
          return 1
      fi
    done
fi
}

IFS=$SAVEIFS
```
