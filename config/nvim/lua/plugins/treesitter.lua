return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",

    config = function()
        require("nvim-treesitter").install({
            ensure_installed = {}, 
            sync_install = false,
            auto_install = false, 
        })

        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                local buf = vim.api.nvim_get_current_buf()
                pcall(vim.treesitter.start, buf)
            end,
        })
    end
}
