return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",

    config = function()
        require("nvim-treesitter.configs").setup {
            ensure_installed = { "help", "c", "lua", "rust", "javascript", "typescript" },
            sync_install = false,
            auto_install = false, -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally

            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        }
    end
}
