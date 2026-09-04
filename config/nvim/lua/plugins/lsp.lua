return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        -- LSP installer
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",

        -- Autocompletion
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "saadparwaiz1/cmp_luasnip",

        -- Snippets
        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets",

        -- Diagnostics picker
        "nvim-telescope/telescope.nvim",
    },

    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({ automatic_enable = true })

        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        -- LSP keymaps
        local on_attach = function(_, bufnr)
            local opts = {
                buffer = bufnr,
                remap = false,
            }

            vim.keymap.set( "n", "<leader>dk", vim.diagnostic.goto_prev, opts)
            vim.keymap.set( "n", "<leader>dj", vim.diagnostic.goto_next, opts)
            vim.keymap.set( "n", "<space>dl", "<cmd>Telescope diagnostics<cr>", opts)
            vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
        end

        -- Common configuration for all LSP servers
        vim.lsp.config("*", { capabilities = capabilities, on_attach = on_attach, })

        -- nvim-cmp
        local cmp = require("cmp")
        local cmp_select = { behavior = cmp.SelectBehavior.Select, }

        cmp.setup({
            mapping = {
                ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                ["<C-y>"] = cmp.mapping.confirm({ select = true, }),
                ["<C-Space>"] = cmp.mapping.complete(),

                ["<Tab>"] = cmp.mapping.select_next_item(cmp_select),
                ["<S-Tab>"] = cmp.mapping.select_prev_item(cmp_select),
            },

            sources = {
                { name = "nvim_lsp" },
                { name = "buffer" },
                { name = "path" },
                { name = "luasnip" },
            },

            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
        })

        vim.diagnostic.config({
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = "E",
                    [vim.diagnostic.severity.WARN] = "W",
                    [vim.diagnostic.severity.HINT] = "H",
                    [vim.diagnostic.severity.INFO] = "I",
                },
            },
        })
    end,
}
