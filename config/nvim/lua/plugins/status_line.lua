return {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    priority = 30,
    opts = { "kyazdani42/nvim-web-devicons" },

    config = function()
            require("lualine").setup {
                    sections = {
                            lualine_x = { "encoding", "filetype" },
                    },
            }
    end
}
