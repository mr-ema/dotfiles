# DotFiles
These are my `.Files`. Feel free to take whatever you want.

</br>

## Quick Navigation
- [Save/Load Gnome Settings](#saveload-gnome-settings)
- [Install](#resources)
- [Examples](#examples)
- [Use Of Install Script](#use-of-install-script)

</br>

## Resources
- [Awesome Dotfiles](https://github.com/webpro/awesome-dotfiles)
- [SE-EDU](https://se-education.org/learningresources/contents/dotfiles/Dotfiles.html)
- [Shell Check](https://www.shellcheck.net/)

</br>
</br>

## Save/Load Gnome Settings
To save all your GNOME settings, you can do
```
dconf dump / > gnome_settings.ini
```

</br>

To load them back
```
dconf load / < gnome_settings.ini
```

</br>

If you only want to save your keybindings, you will need to provide the path to the keybindings
```
dconf dump /org/gnome/desktop/wm/keybindings > gnome_keybindings
```

</br>
</br>

## Install
This script was developed for personal use, so please be cautious when using it,
and do so at your own risk.

Before proceeding with the installation, please be aware of the following considerations:

1. Backup Creation:
    - The `install.sh` script will create a backup of the existing files under the .dotfiles/backup directory.
    - This backup ensures that you have a copy of the original files before they are overwritten.

</br>

2. File Overwriting:
    - During the installation process, the script will overwrite the files specified by the script.
    - It is important to note that the existing versions of these files will be replaced.

</br>

3. Shell Compatibility:
    - The `install.sh` script is written specifically for Bash. Therefore, it is recommended to use Bash for executing the script.

</br>

**Keeping these points in mind, you can proceed with the installation:**

First clone the repository
```
git clone --recurse-submodules https://github.com/mr-ema/dotfiles ~/.dotfiles
```

Then run
```
cd ~/.dotfiles && ./install.sh
```

or
```
cd ~/.dotfiles && ./install.sh --help
```

</br>
</br>

## Examples
Print a list with the names of all files that can be excluded
```
./install.sh --list-exclude
```

Exclude specific files
```
./install.sh --exclude 'bin zsh'
```

Remove a especific linked file
```
./install.sh -rm 'bin'

./install.sh -rm 'pull-apk.sh'
```

</br>
</br>

## Use Of Install Script
By default, the script will create a backup. To skip the backup process,
you can use the `--skip-backup` option. Additionally, you can use the
`--force-copy` option to copy files directly instead of creating symbolic
links. If you need assistance or want to see all available options,
you can use the `--help` option which will display useful information and all available options.

Note that by default, the files will be created in the `$HOME` directory and `$HOME/.config`
You can modify these paths by replacing them with the desired locations.

</br>

### Symbolic Links
The script creates [symbolic links](https://www.futurelearn.com/info/courses/linux-for-bioinformatics/0/steps/201767)
to `~/.config` and `~/` directories linking the configuration files that are inside of `.dotfiles`

Note that by default the script will not attempt to replace already existing symbolic links.
You can change that by passing `--recreate-symlinks` flag.

</br>
