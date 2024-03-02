# DotFiles
These are my `.Files`. Feel free to take whatever you want.

</br>

## Quick Navigation
- [Save/Load Gnome Settings](#saveload-gnome-settings)
- [Install](#resources)
- [Use Of Install Script](#use-of-install-script)

</br>

## Resources
- [Awesome Dotfiles](https://github.com/webpro/awesome-dotfiles)
- [SE-EDU](https://se-education.org/learningresources/contents/dotfiles/Dotfiles.html)
- [Shell Check](https://www.shellcheck.net/)
- [Fish Cheat Sheet](https://devhints.io/fish-shell)

</br>
</br>

## Save/Load Gnome Settings
To save all your GNOME settings, you can do
```
dconf dump / > gnome_settings.ini
```

To load them back
```
dconf load / < gnome_settings.ini
```

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

2. File Overwriting:
    - During the installation process, the script will overwrite the files specified by the script.
    - It is important to note that the existing versions of these files will be replaced.

3. Shell Compatibility:
    - The `install.sh` script should work in most shells. However, there might be compatibility issues with some shells.
    - If any problems are encountered during the installation process, it is recommended to use `bash` to execute the script.

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
`--force-copy` option to copy files directly instead of creating symbolic
links. If you need assistance or want to see all available options,
you can use the `--help` option which will display useful information and all available options.

</br>

> __Note__\
> \
> By default, the files will be created in the `$HOME` directory and `$HOME/.config`
> You can modify these paths by replacing them with the desired locations.

</br>

### Symbolic Links
The script creates [symbolic links](https://www.futurelearn.com/info/courses/linux-for-bioinformatics/0/steps/201767)
to `~/.config` and `~/` directories linking the configuration files that are inside of `.dotfiles`

</br>

> __Note__\
> \
> By default the script will not attempt to replace already existing symbolic links.
> You can change that by passing `--recreate-symlinks` flag.
