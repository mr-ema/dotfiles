# My NeoVim Setup

## Navigation
- [Tips](https://github.com/mr-ema/dotfiles/tree/main/config/nvim#tips)
- [Useful Links](https://github.com/mr-ema/dotfiles/tree/main/config/nvim#useful-links)
- [Intalled Plugins](https://github.com/mr-ema/dotfiles/tree/main/config/nvim#installed-plugins)
- [Utils](https://github.com/mr-ema/dotfiles/tree/main/config/nvim#utils)

## Tips
- Run `:so ~/.config/nvim/lua/kraken/packer.lua | PackerSync` to update or reinstall plugins 
- Run `:Telescope keymaps` to list set keymaps
- Press `<leader>ff` to open telescope and `<leader>cd` to update telescope search path
- Run `:Mason` to list all lsp servers available
- The `.viminfo` is created in `~/.config/nvim/shada/.viminfo` ( see next line ). 
- You can change the name and behaviour of `.viminfo` in `lua/kraken/set.lua => vim.opt.shada`

## Useful links
- [Vim Cheat Sheet](https://vim.rtorr.com/)
- [NeoVim Documentation](https://neovim.io/doc/)
- [Neovim RC From Scratch (_Video_)](https://www.youtube.com/watch?v=w7i4amO_zaE)
- [LSP Servers](https://github.com/williamboman/mason.nvim#commands)
- [LSP Preferences](https://github.com/VonHeikemen/lsp-zero.nvim#choose-your-features)

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
`