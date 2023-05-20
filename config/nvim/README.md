# NeoVim Setup
Here I have my all my `Neovim` configuration. Feel free to explore and copy whatever you like.

</br>

## Navigation
- [Tips](https://github.com/mr-ema/dotfiles/tree/main/config/nvim#tips)
- [My Keymaps](https://github.com/mr-ema/dotfiles/tree/main/config/nvim#my-keymaps)
- [Useful Links](https://github.com/mr-ema/dotfiles/tree/main/config/nvim#useful-links)
- [Intalled Plugins](https://github.com/mr-ema/dotfiles/tree/main/config/nvim#installed-plugins)
- [Utils](https://github.com/mr-ema/dotfiles/tree/main/config/nvim#utils)

</br>

## Tips
- Run `:read !<command> <args>` will insert the output of a shell command into vim [_example_](#example-read-command)

- Run `:lua require("utils").toggle_tranparency()` to toggle theme transparency
- Run `:TSInstall <language_to_install>` to install syntax highlighting and other features for the specific language
- Run `:Telescope keymaps` to list set keymaps
- Press `<leader>cd` to update telescope search path
- Run `:Mason` to list all lsp servers available
- The `.viminfo` and `lazy-lock.json` are created in `~/.config/nvim/shada/.viminfo`. 
- You can change the name and behaviour of `.viminfo` in `lua/kraken/set.lua => vim.opt.shada`

</br>

## My Keymaps
|       Action          |       Shortcut        |
| --------------------- | --------------------- |
| Toggle Transparency   | `<leader>tt`          |
| Toggle Harpoon        | `<leader>h`           |
| Add File To Harpoon   | `<leader>a`           |
| Toggle UndoTree       | `<leader>u`           |
| Open Telescope        |`<leader>ff`           |
| Update Telescope Path | `<leader>cd`          |
| Home Tab              | `th`                  |
| Prev Tab              | `tj`                  |
| Next Tab              | `tk`                  |
| Last Tab              | `tl`                  |

</br>

## Useful links
- [LSP Keybindings](https://github.com/VonHeikemen/lsp-zero.nvim#keybindings)
- [Vim Cheat Sheet](https://vim.rtorr.com/)
- [Vim Events Useful For lazy.nvim](https://tech.saigonist.com/b/code/list-all-vim-script-events.html)
- [NeoVim Documentation](https://neovim.io/doc/)
- [Neovim RC From Scratch (_Video_)](https://www.youtube.com/watch?v=w7i4amO_zaE)
- [LSP Servers](https://github.com/williamboman/mason.nvim#commands)
- [LSP Preferences](https://github.com/VonHeikemen/lsp-zero.nvim#choose-your-features)

</br>

## Installed Plugins
- [Tokyonight](https://github.com/folke/tokyonight.nvim)
- [Lualine](https://github.com/nvim-lualine/lualine.nvim)
- [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- [Harpoon](https://github.com/ThePrimeagen/harpoon)
- [Undotree](https://github.com/mbbill/undotree)
- [Ident-blankline](https://github.com/lukas-reineke/indent-blankline.nvim)
- [Lsp-zero](https://github.com/VonHeikemen/lsp-zero.nvim)
- [Zenmode](https://github.com/folke/zen-mode.nvim)
- [Fugitive](https://github.com/tpope/vim-fugitive)
- [Refactoring](https://github.com/ThePrimeagen/refactoring.nvim#refactoringnvim)

</br>

## Utils
#### Autoinstall packer (_deleted from tree since I migrate to [_lazy.nvim_](https://github.com/folke/lazy.nvim)_)

```lua
local M = {}

function M.check()
        -- check if default packer installation exists
        local handle = io.popen("[ -d ~/.local/share/nvim/site/pack/packer ] && echo 1", "r")
        local packer = handle:read("*n") -- 1 or nil
        handle:close()
        
        -- if packer exists end the function
        if packer == 1 then 
                return
        end

        -- ask for permission to install
        local response = vim.fn.input("I see that you don't have packer installed do you wanna installed? (y/n) ", "y")
    
        -- if not permisison end the function 
        if response ~= 'y' then
                return
        end

        -- default method to install packer
        os.execute("git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim")
        vim.cmd [[so ~/.config/nvim/lua/kraken/packer.lua]]
        vim.cmd [[PackerSync]]
end

return M.check()
```

</br>

## Examples
#### Example Read Command
```
/*******************************************************************
 * text generating running `:read !figlet -f small Vim is awesome` *
 *                                                                 *
 *   __   ___         _                                            *
 *   \ \ / (_)_ __   (_)___  __ ___ __ _____ ___ ___ _ __  ___     *
 *    \ V /| | '  \  | (_-< / _` \ V  V / -_|_-</ _ \ '  \/ -_)    *
 *     \_/ |_|_|_|_| |_/__/ \__,_|\_/\_/\___/__/\___/_|_|_\___|    *
 *                                                                 *
 *******************************************************************/
```

