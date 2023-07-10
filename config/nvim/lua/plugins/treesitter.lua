return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",

    config = function()
        require("nvim-treesitter.configs").setup {
            ensure_installed = { }, -- Leave empty to avoid error in first install
            sync_install = false,
            auto_install = false, -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally

            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        }
    end
}
