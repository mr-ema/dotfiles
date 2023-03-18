# Kitty setup

</br>

**Super Simple And Minimalist Kitty Setup.**

![Logo](https://github.com/mr-ema/dotfiles/blob/main/config/kitty/wifu/screenshot.png?raw=true)

</br>
</br>

## Navigation

- [Tips](https://github.com/mr-ema/dotfiles/tree/main/config/kitty#tips)
- [Useful Links](https://github.com/mr-ema/dotfiles/tree/main/config/kitty#useful-links)
- [Shortcuts](https://github.com/mr-ema/dotfiles/tree/main/config/kitty#shortcuts)
- [Code](https://github.com/mr-ema/dotfiles/tree/main/config/kitty#tips)

</br>

## Tips

- Backgrounds must be in `.png` format you can use [jpg2png](https://jpg2png.com/) to convert `.jpg` files
- Compress your `.png` image to gain huge performance
- You can change the background in `custom.conf`

</br>

## Useful Links

- [Compress Images](https://compresspng.com/)
- [JPG To PNG](https://jpg2png.com/)
- [Kitty Config](https://sw.kovidgoyal.net/kitty/conf)
- [Kitty Shortcuts](https://sw.kovidgoyal.net/kitty/overview)
- [Customize Bottom Bar](https://sw.kovidgoyal.net/kitty/conf/#tab-bar)

</br>

## Shortcuts

| Action                | Shortcut              |
| --------------------- | --------------------- |
| Edit kitty.conf       | `ctrl+shift+f2`       |
| Reload `kitty.conf`   | `ctrl+shift+f5`       |
| New Window            | `ctrl+shift+enter`    |
| New Tab               | `ctrl+shift+t`        |
| Go To Tab [**n**]     | `kitty_mod+n`         |

</br>

## Code

```
# vim:fileencoding=utf-8:foldmethod=marker
# more options in: https://sw.kovidgoyal.net/kitty/conf/

# Mouse -----------------
mouse_hide_wait 1.0

# Cursor ----------------
cursor_blink_interval 0.8
cursor_shape block

# Font ------------------
font_size 14.0
modify_font cell_height 110%

font_family      jetbrains mono
bold_font        jetbrains mono bold
italic_font      jetbrains mono italic
bold_italic_font jetbrains mono bold italic

# Background ------------------------ 
background_image ./wifu/default.png
background_image_layout scaled
background_image_linear yes
background_tint 0.9

# Window -------------------
hide_window_decorations yes
draw_minimal_borders yes
enabled_layouts Grid, Fat, Splits, Stack

placement_strategy top-left
window_margin_width 1
window_padding_width 6
window_border_width 0.5pt
active_border_color #5e2a38
inactive_border_color #38131c

remember_window_size  yes
initial_window_width  640
initial_window_height 400

# Tab Bar -----------------
tab_title_template "{index}"
tab_bar_edge bottom
tab_bar_min_tabs 1
tab_bar_margin_width 0.0
tab_bar_margin_height 0.0 0.0
tab_bar_style powerline
tab_bar_align left
tab_switch_strategy previous
tab_powerline_style angled

active_tab_foreground   #EEE6CE
active_tab_background   #B8405E
active_tab_font_style   normal
inactive_tab_foreground #DCD5C2
inactive_tab_background #873248
inactive_tab_font_style normal

# Advanced ---------------------
editor vim

# Tab Keymaps ---------------------------------------
map kitty_mod+1 goto_tab 1
map kitty_mod+2 goto_tab 2
map kitty_mod+3 goto_tab 3
map kitty_mod+4 goto_tab 4
map kitty_mod+5 goto_tab 5
map kitty_mod+6 goto_tab 6
map kitty_mod+7 goto_tab 7
map kitty_mod+8 goto_tab 8
map kitty_mod+9 goto_tab 9

# Windows Keymaps -------------------------------
map ctrl+shift+enter new_window_with_cwd
map kitty_mod+z toggle_layout stack

map ctrl+l resize_window narrower
map ctrl+h resize_window wider
map ctrl+k resize_window taller
map ctrl+j resize_window shorter 3
map ctrl+r resize_window reset
```
