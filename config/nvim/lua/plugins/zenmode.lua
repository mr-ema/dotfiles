return {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    keys = {
        { "<leader>ze", "<cmd>ZenMode<cr>", desc = "ZenMode" },
    },

    config = function()
        require("zen-mode").setup {
            window = {
                width = 109,
                height = 1,
            },
            plugins = {
                options = {
                    enabled = true,
                    ruler = false,
                    showcmd = false,
                },
            },
        }
    end
}
