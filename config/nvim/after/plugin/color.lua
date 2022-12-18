local ok, tokyonight = pcall(require, 'tokyonight')
if not ok then return end

-- tokyonight custom configuration
tokyonight.setup {
        style = "night", -- [ "night", "storm", "day", "moon" ]
        transparent = true,
        sidebars = { "qf", "help" }
}

vim.cmd [[colorscheme tokyonight]]
