local ok, zenmode = pcall(require, 'zen-mode')
if not ok then return end


vim.keymap.set('n', '<leader>ze', '<cmd>ZenMode<cr>')

zenmode.setup {
        window = {
                width = 109, -- width of the Zen window
                height = 1, -- height of the Zen window
        },
        plugins = {
                -- disable some global vim options (vim.o...)
                -- comment the lines to not apply the options
                options = {
                        enabled = true,
                        ruler = false, -- disables the ruler text in the cmd line area
                        showcmd = false, -- disables the command in the last line of the screen
                },
        }
}
