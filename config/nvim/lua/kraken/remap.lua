-- Vim
vim.keymap.set('n', '<leader>pv', '<cmd>Ex<cr>')        -- go to previous directory
vim.keymap.set('n', '<C-d>', '<C-d>zz')                 -- move haft screen down and center
vim.keymap.set('n', '<C-u>', '<C-u>zz')                 -- move haft screen up and center
vim.keymap.set('n', 'n', 'nzzzv')                       -- center screen when searching pattern
vim.keymap.set('n', 'N', 'Nzzzv')                       -- center screen when searching pattern
vim.keymap.set('n', 'U', '<C-r>')                       -- redo change 

-- tabs
vim.keymap.set('n', 'th', '<cmd>tabfirst<cr>')          -- go to first tab
vim.keymap.set('n', 'tk', '<cmd>tabnext<cr>')           -- go to next tab
vim.keymap.set('n', 'tj', '<cmd>tabprev<cr>')           -- go to prev tab
vim.keymap.set('n', 'tl', '<cmd>tablast<cr>')           -- go to last tab

-- utils
vim.keymap.set('n', 'tt', '<cmd>lua require("utils").toggle_transparency()<cr>') -- toggle theme transparency
