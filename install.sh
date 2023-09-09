#!/bin/sh

dot_dir=$HOME/.dotfiles # where the dotfiles are

# arguments flags
backup=1
rm_symlinks=0
use_copy=0

backup_path=$HOME/.dotfiles/backup
backup_path="$backup_path/$(date +%H-%M-%S)"

# names of files to symlink or copy ( the dot is optional if you remove it it will link as 'fonts' )
home_files=".zshenv .gitconfig .fonts"
config_dirs="zsh nvim kitty"

usage() {
        name=$(basename "$0")

        echo " Usage: $name [arg_1 ... arg_n]"
        echo " Create symlinks or copy dotfiles to the target directories defined in the script."
        echo ""
        echo " Options:"
        echo "   --skip-backup       Skip creating a backup of existing files."
        echo "   --rm-symlinks       Remove symbolic links if already exists."
        echo "   --force-copy        Use copy instead of symbolic link."
}

for arg in "$@"; do
        case $arg in
                "--help")
                        usage
                        exit 0
                ;;
                "--skip-backup")
                        backup=0
                ;;
                "--rm-symlinks")
                        rm_symlinks=1
                ;;
                "--force-copy")
                        use_copy=1
                ;;
                *)
                        echo "Unknown argument: $arg"
                        exit 1
                ;;
        esac
done

deletetor() {
        file_path="$1"

        if [ "$file_path" = "/" ]; then
                echo "[REMOVE] REMOVE FROM '/' IS NOT ALLOWED"
        else
                if [ -L "$file_path" ]; then
                        rm "$file_path"
                        echo "[REMOVE] SYMLINK $file_path"
                elif [ -d "$file_path" ]; then
                        rm -r "$file_path"
                        echo "[REMOVE] DIR $file_path"
                elif [ -f "$file_path" ]; then
                        rm "$file_path"
                        echo "[REMOVE] FILE $file_path"
                fi
        fi
}

makebackup() {
        file_path="$1"

        if [ -L "$file_path" ]; then
                return
        elif [ -d "$file_path" ]; then
                mkdir -p "$backup_path"

                cp -r "$file_path" "$backup_path"
                echo "[BACKUP] DIR $file_path IN $backup_path"
        elif [ -f "$file_path" ]; then
                mkdir -p "$backup_path"

                cp "$file_path" "$backup_path"
                echo "[BACKUP] FILE $file_path IN $backup_path"
        fi
}

copynator() {
        target_path="${1}"
        source_path=""
        file_path=""

        for file_name in ${2}; do
                file_path=$(echo "${target_path:?}/$file_name" | tr -s '/')
                source_path=$(find "${dot_dir}" -regex ".*/\(.*${file_name}.*\|.*\.${file_name}.*\)" | head -n 1)

                if [ "$backup" -eq 1 ]; then
                        makebackup "${file_path}"
                fi

                deletetor "${file_path}"

                if [ -d "${source_path}" ]; then
                        cp -r "${source_path}" "${file_path}"
                        echo "[COPY] DIR ${source_path} TO ${file_path}"
                else
                        cp "${source_path}" "${file_path}"
                        echo "[COPY] FILE ${source_path} TO ${file_path}"
                fi
        done
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

                        source_path=$(find "${dot_dir}" -regex ".*/\(.*${file_name}.*\|.*\.${file_name}.*\)" | head -n 1)
                        ln -sv "${source_path}" "${file_path}"
                fi
        done
}

# Check if 'ln' command exists
if command -v ln > /dev/null 2>&1 && [ "$use_copy" -eq 0 ]; then
        echo "[CREATING SYMBOLIC LINKS]........................."
        syminator "$HOME/.config" "$config_dirs"
        syminator "$HOME" "$home_files"
else
        echo "[COPYING DOTFILES]................................"
        copynator "$HOME/.config" "$config_dirs"
        copynator "$HOME" "$home_files"
fi
