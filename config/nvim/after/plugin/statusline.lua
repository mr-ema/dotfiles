local ok, lualine = pcall(require, 'lualine')
if not ok then return end

lualine.setup {
        sections = {
                lualine_x = { 'encoding', 'filetype' },
        },
}
