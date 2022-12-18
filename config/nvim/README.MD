# My NeoVim Setup 

## Tips
- Run `so ~/.config/nvim/lua/kraken/packer.lua | PackerSync` to update or reinstall plugins 
- Run `Telescope keymaps` to list set keymaps
- Press `<leader>ff` to open telescope and `<leader>cd` to update telescope search path
- Run `Mason` to list all lsp servers available
- The `.viminfo` is created in `~/.config/nvim/shada/.viminfo` ( see next line ). 
- You can change the name and behaviour of `.viminfo` in `lua/kraken/set.lua => vim.opt.shada`

## Useful links
- [Vim Cheat Sheet](https://vim.rtorr.com/)
- [NeoVim Documentation](https://neovim.io/doc/)
- [ThePrimeagen Video](https://www.youtube.com/watch?v=w7i4amO_zaE)
- [LSP Servers](https://github.com/williamboman/mason.nvim#commands)
- [LSP Preferences](https://github.com/VonHeikemen/lsp-zero.nvim#choose-your-features)

## Plugins
- [tokyonight](https://github.com/folke/tokyonight.nvim)
- [lualine](https://github.com/nvim-lualine/lualine.nvim)
- [treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [telescope](https://github.com/nvim-telescope/telescope.nvim)
- [harpoon](https://github.com/ThePrimeagen/harpoon)
- [undotree](https://github.com/mbbill/undotree)
- [ident-blankline](https://github.com/lukas-reineke/indent-blankline.nvim)
- [lsp-zero](https://github.com/VonHeikemen/lsp-zero.nvim)
- [zenmode](https://github.com/folke/zen-mode.nvim)
- [fugitive](https://github.com/tpope/vim-fugitive)

## Utils
#### Autoinstall packer

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
