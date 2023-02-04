return {
    "ThePrimeagen/harpoon",

    keys = {
        { "<leader>a", "<cmd>lua require('harpoon.mark').add_file()<cr>" },
        { "<leader>h", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>" },

        { "<C-h>", function() require('harpoon.ui').nav_file(1) end },
        { "<C-t>", function() require('harpoon.ui').nav_file(2) end },
        { "<C-n>", function() require('harpoon.ui').nav_file(3) end },
        { "<C-s>", function() require('harpoon.ui').nav_file(4) end },
    },
}

