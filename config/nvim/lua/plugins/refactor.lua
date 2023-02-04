return {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter"
    },

    keys = {
        { "<leader>rr", "<cmd>lua require('refactoring').select_refactor()<cr>", mode = "v" },
    },
}
