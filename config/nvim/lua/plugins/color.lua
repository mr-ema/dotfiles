return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,

    config = function()
        require("tokyonight").setup {
            style = "night", -- [ "night", "storm", "day", "moon" ]
            transparent = true,
            sidebars = { "qf", "help" }
        }
        vim.cmd [[colorscheme tokyonight]]
    end
}

