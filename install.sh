#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Zero-Clause BSD
#
# Permission to use, copy, modify, and/or distribute this software for
# any purpose with or without fee is hereby granted.
# 
# THE SOFTWARE IS PROVIDED “AS IS” AND THE AUTHOR DISCLAIMS ALL
# WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES
# OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE
# FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY
# DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN
# AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT
# OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
# -----------------------------------------------------------------------------

if [ -z "$BASH_VERSION" ]; then
    echo "error: This script must be executed with Bash." >&2
    exit 1
fi

dot_dir="$HOME/.dotfiles" # where the dotfiles are
bin_path="$HOME/.bin" # where dotfiles shell scripts will be link or hard-copied

# arguments flags
backup=1
recreate_symlinks=0
use_copy=0
should_remove_files=0

backup_path="$dot_dir/backup"
backup_file="$backup_path/$(date +%H-%M-%S)"

# names of files to symlink or copy ( the dot is optional if you remove it it will link as 'fonts' )
home_files=".zshenv .gitconfig .fonts"
config_files="zsh fish nvim kitty tmux"
binaries="$(ls $dot_dir/bin)"

usage() {
        name=$(basename "$0")

        echo " $name [OPTIONS...]"
        echo ""
        echo " DESCRIPTION"
        echo "  This script facilitates the management of dotfiles by creating"
        echo "  symbolic links to target files defined within the script."
        echo "  If symbolic links are unavailable, files are copied directly."
        echo "  Additionally, the script allows for file exclusion using the '--exclude' option."
        echo "  You can get a list of excludable files by using '--list-exclude' option."
        echo ""
        echo ""
        echo " The following options are available:"
        echo ""
        echo "  --skip-backup"
        echo "      Skip creating a backup of existing files."
        echo ""
        echo "  --recreate-symlinks"
        echo "      By default, existing symbolic links are skipped during symlink creation."
        echo "      Use this option to force the script to recreate symbolic links, even if they already exist."
        echo ""
        echo "  --force-copy"
        echo "      Use copy instead of symbolic link. This will use 'cp' command"
        echo "      which will overwrite your files. By default, a backup will be made"
        echo "      which can be omitted by passing '--skip-backup' option."
        echo ""
        echo "  --backup-path [$backup_path]"
        echo "      Set a backup path the default is '$backup_path'"
        echo "      For symbolic links, the backup will be skipped."
        echo ""
        echo "          USAGE: [ ./$name --backup-path '~/.my-backup' ]"
        echo ""
        echo "  --list-exclude"
        echo "      Prints a list with the names of all files that can be excluded."
        echo ""
        echo "  --remove-all, --rm-all"
        echo "      Remove all symbolic links and hard-copied dotfiles. This option"
        echo "      can be used along with '--exclude' to provide a list of"
        echo "      files that will be excluded from the deletion process."
        echo "      A backup will be made if the target files are not symbolic links."
        echo ""
        echo "          USAGE: [ ./$name --rm-all-dotfiles ] or [ ./$name --rm-all-dotfiles --exclude 'zsh, ...' ]"
        echo ""
        echo "  -rm, --remove"
        echo "      Remove specific symbolic links and hard-copied dotfiles."
        echo "      A backup will be made if the target file is not a symbolic link."
        echo ""
        echo "          USAGE: [ ./$name --rm-dotfiles 'zsh, ...' ]"
        echo ""
        echo "  -e or --exclude"
        echo "      Exclude specific files from installation."
        echo "      You could use '--list-exclude' to show a list of excludable files."
        echo ""
        echo "          USAGE: [ ./$name --exclude 'zsh kitty ...' ] or [ ./$name --exclude 'zsh, kitty, ...' ]"
        echo ""
        echo "  -h or --help"
        echo "      Display this help message."
        echo ""
        echo ""
        echo " EXAMPLES"
        echo ""
        echo "  1. Using copy instead of symbolic links (without backup)"
        echo "      ./$name --force-copy --skip-backup"
        echo ""
        echo "  2. Using copy with a custom backup path"
        echo "      ./$name --force-copy --backup-path '~/my-backup'"
        echo ""
        echo "  3. Recreating symbolic links excluding specific files"
        echo "      ./$name --exclude 'zsh, tmux' --recreate-symlinks"
        echo ""
        echo "  4. Removing specific files"
        echo "      ./$name --remove 'zsh, tmux'"
        echo ""
}

while [ "$#" -gt 0 ]; do
        name=$(basename "$0")

        case $1 in
        "")
                # skip
        ;;
        "--help" | "-h")
                usage
                exit 0
        ;;
        "--skip-backup")
                backup=0
        ;;
        "--remove" | "-rm")
                if [ -z "$2" ] || [ "${2#--}" != "$2" ]; then
                        echo "./$name: Expected [ $1 'zsh ...' ] but instead got [ $1 $2 ]" >&2
                        exit 1
                fi

                files_to_rm=$(echo "$2" | tr ',' ' ')
                temp_home_files=$(echo "$home_files")
                temp_config_files=$(echo "$config_files")
                home_files=""
                config_files=""

                for name in ${files_to_rm}; do
                        if echo "$temp_home_files" | grep -qE "(^|\s)$name($|\s)"; then
                                home_files=$(echo "${home_files} ${name}")

                        elif echo "$temp_config_files" | grep -qE "(^|\s)$name($|\s)"; then
                                config_files=$(echo "${config_files} ${name}")
                        fi
                done

                # Remove extra spaces resulting from removals
                config_files=$(echo "$config_files" | tr -s ' ')
                home_files=$(echo "$home_files" | tr -s ' ')

                # Trim leading and trailing spaces
                home_files=$(echo "$home_files" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
                config_files=$(echo "$config_files" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

                should_remove_files=1
                break # do not parse more options
        ;;
        "--remove-all" | "--rm-all")
                should_remove_files=1
        ;;
        "--recreate-symlinks")
                recreate_symlinks=1
        ;;
        "--force-copy")
                use_copy=1
        ;;
        "--list-exclude")
            excludable_files=$(echo "$home_files $config_files")
            for file_name in ${excludable_files}; do
                echo " $file_name"
            done
            exit 0
        ;;
        "--backup-path")
                if [ -z "$2" ] || [ "${2#--}" != "$2" ]; then
                        echo "./$name: Expected [ $1 '~/path-to-backup' ] but instead got [ $1 $2 ]" >&2
                        exit 1
                fi

                backup_path="$2"
                shift
        ;;
        "--exclude" | "-e")
                if [ -z "$2" ] || [ "${2#--}" != "$2" ]; then
                        echo "./$name: Expected [ $1 'zsh ...' ] but instead got [ $1 $2 ]" >&2
                        exit 1
                fi

                files_to_rm=$(echo "$2" | tr ',' ' ')
                for name in ${files_to_rm}; do
                        home_files=$(echo "$home_files" | sed "s/\b$name\b//g")
                        config_files=$(echo "$config_files" | sed "s/\b$name\b//g")
                done

                # Remove extra spaces resulting from removals
                config_files=$(echo "$config_files" | tr -s ' ')
                home_files=$(echo "$home_files" | tr -s ' ')

                # Trim leading and trailing spaces
                home_files=$(echo "$home_files" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
                config_files=$(echo "$config_files" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

                shift
        ;;
        *)
                echo "Unknown argument: $1" >&2
                exit 1
        ;;
        esac
        shift
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

find_dotfile() {
        file_name="$1"
        file_name="${file_name#.}"

        path=$(find "${dot_dir}" -name "${file_name}" -o -name ".${file_name}" | head -n 1)

        echo "$path"
}

makebackup() {
        file_path="$1"

        if [ -L "$file_path" ]; then
                return
        elif [ -d "$file_path" ]; then
                mkdir -p "$backup_file"

                cp -r "$file_path" "$backup_file"
                echo "[BACKUP] DIR $file_path IN $backup_file"
        elif [ -f "$file_path" ]; then
                mkdir -p "$backup_file"

                cp "$file_path" "$backup_file"
                echo "[BACKUP] FILE $file_path IN $backup_file"
        fi
}

removator() {
        target_path="${1}"
        source_path=""
        file_path=""

        for file_name in ${2}; do
                file_path=$(echo "${target_path:?}/$file_name" | tr -s '/')
                source_path=$(find_dotfile "${file_name}")

                if [ "$backup" -eq 1 ]; then
                        makebackup "${file_path}"
                fi

                deletetor "${file_path}"
        done
}

copynator() {
        target_path="${1}"
        source_path=""
        file_path=""

        for file_name in ${2}; do
                file_path=$(echo "${target_path:?}/$file_name" | tr -s '/')
                source_path=$(find_dotfile "${file_name}")

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

                if [ -L "${file_path}" ] && [ "$recreate_symlinks" -eq 0 ]; then
                        echo "[SYMLINK] TO ${file_path} ALREADY EXISTS"
                else
                        if [ "$backup" -eq 1 ]; then
                                makebackup "${file_path}"
                        fi

                        deletetor "${file_path}"

                        source_path=$(find_dotfile "${file_name}")
                        ln -sv "${source_path}" "${file_path}"
                fi
        done
}

if [ "$should_remove_files" -eq 1 ]; then
        removator "$HOME/.config" "$config_files"
        removator "$HOME" "$home_files"
        removator "${bin_path}" "${binaries}"

        exit 0
fi

# Check if 'ln' command exists
if command -v ln > /dev/null 2>&1 && [ "$use_copy" -eq 0 ]; then
        echo "[CREATING SYMBOLIC LINKS]........................."
        syminator "$HOME/.config" "$config_files"
        syminator "$HOME" "$home_files"

        for binary in "${binaries}"; do
                syminator "${bin_path}" "${binary}"
        done
else
        echo "[COPYING DOTFILES]................................"
        copynator "$HOME/.config" "$config_files"
        copynator "$HOME" "$home_files"
fi
