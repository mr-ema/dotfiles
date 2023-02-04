return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    cmd = "Telescope",
    dependencies = { "nvim-lua/plenary.nvim" },

    keys = {
        {"<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Telescope" },
        {"<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Telescope" },
        {"<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Telescope" },
        {"<leader>fh", "<cmd>Telescope help_tags<cr>",  desc = "Telescope" },
    },

    config = function()
        require("telescope").setup {
            pickers = {
                find_files = {
                    mappings = {
                        n = {
                            ["cd"] = function(prompt_bufnr)
                                local selection = require("telescope.actions.state").get_selected_entry()
                                local dir = vim.fn.fnamemodify(selection.path, ":p:h")
                                require("telescope.actions").close(prompt_bufnr)
                                -- Depending on what you want put `cd`, `lcd`, `tcd`
                                vim.cmd(string.format("silent lcd %s", dir))
                            end
                        }
                    }
                },
            }
        }
    end
}
