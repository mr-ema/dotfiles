return {
    "ThePrimeagen/harpoon",

    keys = {
        { "<leader>a", "<cmd>lua require('harpoon.mark').add_file()<cr>" },
        { "<leader>h", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>" },

        { "<leader>1h", function() require('harpoon.ui').nav_file(1) end },
        { "<leader>2h", function() require('harpoon.ui').nav_file(2) end },
        { "<leader>3h", function() require('harpoon.ui').nav_file(3) end },
        { "<leader>4h", function() require('harpoon.ui').nav_file(4) end },
    },
}

