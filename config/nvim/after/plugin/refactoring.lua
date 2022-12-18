local ok, refactoring = pcall(require, 'refactoring');
if not ok then return end

-- Keymaps
-- prompt for a refactor to apply when the remap is triggered
vim.keymap.set("v", "<leader>rr", ":lua require('refactoring').select_refactor()<CR>", { noremap = true, silent = true, expr = false })

refactoring.setup{}
