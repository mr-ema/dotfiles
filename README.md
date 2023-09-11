# DotFiles
These are my `.Files`. Feel free to take whatever you want.

</br>

## Quick Navigation
- [Install](https://github.com/mr-ema/dotfiles#resources)
- [Use Of Install Script](https://github.com/mr-ema/dotfiles#use-of-install-script)

</br>

## Resources
- [Awesome Dotfiles](https://github.com/webpro/awesome-dotfiles)
- [SE-EDU](https://se-education.org/learningresources/contents/dotfiles/Dotfiles.html)
- [Shell Check](https://www.shellcheck.net/)

</br>
</br>

## Install
Before proceeding with the installation, please be aware of the following considerations:

1. Backup Creation:
    - The install.sh script will create a backup of the existing files under the .dotfiles/backup directory.
    - This backup ensures that you have a copy of the original files before they are overwritten.

2. File Overwriting:
    - During the installation process, the script will overwrite the files specified by the script.
    - It is important to note that the existing versions of these files will be replaced.

Keeping these points in mind, you can proceed with the installation.

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
By default, the script will create a backup. To skip the backup process,
you can use the `--skip-backup` option. Additionally, you can use the
`--force-copy` option to copy the files instead of creating symbolic
links. If you need assistance or want to see all available options,
you can use the `--help` option.

### Variables
- `config_files`: An array with the name of your configuration files.
- `home_files`: files that will be link or copy into `$HOME` dir.

</br>

```bash
# Variables - (Array Variables Has To Be Separated By A Space)

dot_dir=~/.dotfiles                     # dir where your dots files live
backup_path=~/.dotfiles/backup          # where make the backup

home_files=".zshenv .gitconfig"         # files or dirs that goes in $HOME
config_files="zsh nvim kitty"           # files that goes in $HOME/.config
```

</br>

> __Note__\
> \
> By default, the files will be created in the `$HOME` directory and `$HOME/.config`
> You can modify these paths by replacing them with the desired locations.

</br>

### Sym Links
This part of the script create [symbolic links](https://www.futurelearn.com/info/courses/linux-for-bioinformatics/0/steps/201767)
to `~/.config` and `~/` linking the configuration files inside `.dotfiles`

</br>

> __Note__\
> \
> By default the script will not attempt to remove the symbolic links.
> You can change that by passing `--rm-symlinks` flag.

</br>

```bash
find_dotfile() {
        file_name="$1"
        file_name=$(echo "$file_name" | tr -d '.')

        path=$(find "${dot_dir}" -name "${file_name}" -o -name ".${file_name}" | head -n 1)

        echo "$path"
}

syminator() {
        target_path="${1}"
        source_path=""
        file_path=""

        for file_name in ${2}; do
                file_path=$(echo "${target_path:?}/$file_name" | tr -s '/')

                if [ -L "${file_path}" ] && [ "$rm_symlinks" -eq 0 ]; then
                        echo "[SYMLINK] TO ${file_path} ALREADY EXISTS"
                else
                        if [ "$backup" -eq 1 ]; then
                                makebackup "${file_path}"
                        fi

                        deletetor "${file_path}"

                        source_path=$(find_dotfile "${file_name}")
                        echo "$file_name" > /dev/pts/0
                        ln -sv "${source_path}" "${file_path}"
                fi
        done
}

echo "[CREATING SYMBOLIC LINKS]........................."
syminator "$HOME/.config" "$config_dirs"
syminator "$HOME" "$home_files"
```
