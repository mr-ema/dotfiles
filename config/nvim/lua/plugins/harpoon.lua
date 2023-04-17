return {
    "ThePrimeagen/harpoon",

    keys = {
        { "<leader>a", "<cmd>lua require('harpoon.mark').add_file()<cr>" },
        { "<leader>h", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>" },

        { "<leader>h1", function() require('harpoon.ui').nav_file(1) end },
        { "<leader>h2", function() require('harpoon.ui').nav_file(2) end },
        { "<leader>h3", function() require('harpoon.ui').nav_file(3) end },
        { "<leader>h4", function() require('harpoon.ui').nav_file(4) end },
    },
}

