return {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v1.x",
    event = "BufRead",
    dependencies = {
        -- LSP Support
        "neovim/nvim-lspconfig",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",

        -- Autocompletion
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",

        -- Snippets
        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets",
    },

    config = function()
        local lsp = require("lsp-zero")
        -- use recommended settings 
        lsp.preset('recommended')

        -- when add more, remember have the language installed 
        -- for example if wants install rust_analizer you must have rust installed.
        lsp.ensure_installed({ 'sumneko_lua' })

        local cmp = require('cmp')
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        local cmp_mappings = lsp.defaults.cmp_mappings({
            ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
            ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
            ['<C-y>'] = cmp.mapping.confirm({ select = true }),
            ['<C-Space>'] = cmp.mapping.complete(),
        })

        --- keymaps ---
        lsp.on_attach(function(client, bufnr)
            local opts = { buffer = bufnr, remap = false }

            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', '<leader>gt', vim.lsp.buf.type_definition, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', '<leader>dk', vim.diagnostic.goto_prev, opts)
            vim.keymap.set('n', '<leader>dj', vim.diagnostic.goto_next, opts)
            vim.keymap.set('n', '<space>dl', '<cmd>Telescope diagnostics<cr>', opts) 
        end )

        lsp.set_preferences({
            configure_diagnostics = false, -- disable to show diagnostic alogside definition

            sign_icons = {
                error = 'E',
                warn = 'W',
                hint = 'H',
                info = 'I'
            },
        })

        lsp.setup()
    end
}
