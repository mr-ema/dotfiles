-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
        -- Packer can manage itself
        use 'wbthomason/packer.nvim'

        -- TokyoNight Theme
        use 'folke/tokyonight.nvim'

        -- Telescope [grep live]
        use { 'nvim-telescope/telescope.nvim', tag = '0.1.0', requires = { 'nvim-lua/plenary.nvim' } }

        -- Ident Lines
        use 'lukas-reineke/indent-blankline.nvim'

        -- Treesitter
        use { 'nvim-treesitter/nvim-treesitter', run = ':TSUdate' }

        -- Status line
        use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }

        -- Zen mode
        use 'folke/zen-mode.nvim'

        -- Harpoon
        use 'ThePrimeagen/harpoon'

        -- Undotree
        use 'mbbill/undotree'

        -- Fugitive
        use 'tpope/vim-fugitive'

        -- Refactoring
        use { "ThePrimeagen/refactoring.nvim", requires = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" } }

        -- lsp 
        use {
                'VonHeikemen/lsp-zero.nvim',
                requires = {
                        -- LSP Support
                        {'neovim/nvim-lspconfig'},
                        {'williamboman/mason.nvim'},
                        {'williamboman/mason-lspconfig.nvim'},

                        -- Autocompletion
                        {'hrsh7th/nvim-cmp'},
                        {'hrsh7th/cmp-buffer'},
                        {'hrsh7th/cmp-path'},
                        {'saadparwaiz1/cmp_luasnip'},
                        {'hrsh7th/cmp-nvim-lsp'},
                        {'hrsh7th/cmp-nvim-lua'},

                        -- Snippets
                        {'L3MON4D3/LuaSnip'},
                        {'rafamadriz/friendly-snippets'},
                }
        }
end)
