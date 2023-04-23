-------------------------------------------------------
-- HERE YOU CAN SOURCE ALL FILES THAT YOU WANNA LOAD --
-------------------------------------------------------
-- or you can put all your utils in one file

local utils = {}

--[[change 'tabstop','shiftwidth' and 'softtabstop' to n]]
function utils.set_indent_to(n)
        n = n or 4
        vim.bo.tabstop = n             -- the width of a hard tabstop measured in "spaces"
        vim.bo.softtabstop = n         -- the size of an "indent". It's also measured in spaces
        vim.bo.shiftwidth = n          -- sets the number of columns for a TAB
end

--[[toggle transparency in tokyonight plugin]]
function utils.toggle_transparency()
        local theme = require("tokyonight.config").options
        theme.transparent = not theme.transparent
        vim.cmd("colorscheme tokyonight-" .. theme.style)
end

return utils
