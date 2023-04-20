# Bin
Here, I have all my binary files for apps, tools and languages, such as Neovim, Inkscape and Zig,
in their latest versions. **Feel free to explore and copy whatever you like.**

</br>
</br>

## Important
- For this to work you have to add `$HOME/bin` to the `PATH` in bash or zsh [_more about path_](https://www.baeldung.com/linux/path-variable)

- This will be local to the current user if you want to make available for all users, you need
to use `usr/local` intead

</br>

## Installing
Third-party sofware should be install under `/home` or `/user/local`.

</br>

### AppImages
For AppImages, you can store them in:
- All users { `/opt`, `/user/local/share`, `/user/local` }
- One user  { `.local/share`, `.local`, `~/desktop`}

After storing them, you can create a desktop entry and a symlink to the image to use it as a command.
- Symlink `ln -s ~/.local/share/<app> ~/bin/<appName>` or `ln -s /user/local/share/<app> /usr/local/bin/<appName>`
- Desktop entry in `~/.local/share/applications`

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

### Other
For binaries, you can do the same as for AppImages. However sometimes
you may ommit the desktop entry for tools or programming languages.

