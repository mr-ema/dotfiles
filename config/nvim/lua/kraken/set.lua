-----------------------------------------------------------------------
-- MORE HERE: https://neovim.io/doc/user/options.html#option-summary --
-- OR TYPE: ':help option-list' in the command line                  --
-----------------------------------------------------------------------

-- basically where .viminfo file lives and how it behave.
-- more here: https://neovim.io/doc/user/options.html#'shada'
vim.opt.shada = "!,'100,<50,s10,h,n~/.config/nvim/shada/.viminfo"

vim.opt.background = "dark"     -- vim editor background 'dark/light'
vim.opt.guicursor = ""          -- settings for cursor shape and blinking  

vim.opt.nu = true               -- print the line number in front of each line
vim.opt.relativenumber = true   -- show relative line number in front of each line

vim.opt.tabstop = 8             -- the width of a hard tabstop measured in "spaces"
vim.opt.softtabstop = 8         -- the size of an "indent". It's also measured in spaces
vim.opt.shiftwidth = 8          -- sets the number of columns for a TAB
vim.opt.expandtab = true        -- enabling this will make the tab key insert spaces instead of tab characters.
vim.opt.hlsearch = false        -- highlight matches with last search pattern  
vim.opt.incsearch = true        -- hIghlight match while typing search pattern

vim.opt.smartindent = true      -- smart autoindenting for C programs

vim.opt.wrap = false            -- long lines wrap and continue on the next line  

vim.g.mapleader = " "           -- set «leader» key to 'SPACE'
