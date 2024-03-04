# Enchanted Scripts Vault
Step into the Enchanted Scripts Vault, where your binaries and scripts
become the sacred artifacts of your digital kingdom. With mystical
configurations and bewitching automation, this repository promises
to empower your workflow with unparalleled efficiency. Embrace the
magic with meticulously crafted binaries and spellbinding scripts,
each imbued with the essence of arcane craftsmanship. Join the quest
to unlock the secrets of digital sorcery and harness the full potential
of your enchanted tools. Welcome to the Enchanted Scripts Vault, where
every executable is a manifestation of your coding prowess, and every
script is a spell waiting to be cast. (_AI Generated_)

</br>

> [!NOTE] 
> For this to work, remember to add `$HOME/bin` or `$HOME/.bin` to your `$PATH` [_More about path_](https://www.baeldung.com/linux/path-variable)

</br>
</br>

## Important
This will be local to the current user if you want to make available for all users, you need
to use `usr/local` intead

</br>
</br>

## Installing
Third-party sofware should be install under `/home` or `/user/local`.

</br>

### AppImages
For AppImages, you can store them in:
- All users { `/opt`, `/user/local/share`, `/user/local` }
- One user  { `.local/share`, `.local`, `~/desktop`}

</br>

After storing them, you can create a desktop entry and a symlink to the image to use it as a command.
- Symlink `ln -s ~/.local/share/<app> ~/bin/<appName>` or `ln -s /user/local/share/<app> /usr/local/bin/<appName>`
- Desktop entry in `~/.local/share/applications`

</br>

**Desktop Entry**
```desktop
# more info here: https://wiki.archlinux.org/title/desktop_entries

[Desktop Entry]
Version=1.0
Type=Application
Name=inkscape
Comment=Powerful svg editor
Exec=/home/<user>/.local/share/inkscape/Inkscape-b0a8486-x86_64.AppImage
Icon=/home/<user>/.local/share/inkscape/inkscape-48.png
Categories=Utility;
```

</br>

### Other
For binaries, you can do the same as for AppImages. However sometimes
you may ommit the desktop entry for tools or programming languages.

