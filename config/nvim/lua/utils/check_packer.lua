----------------------------------
-- Check if packer is installed --
----------------------------------
-- TODO: Add more installation options for window/unix(linux, mac)

local M = {}

function M.check()
        -- check if default packer installation exists
        local handle = io.popen("[ -d ~/.local/share/nvim/site/pack/packer ] && echo 1", "r")
        local packer = handle:read("*n") -- 1 or nil
        handle:close()

        -- if packer exists end the function
        if packer == 1 then
                return
        end

        -- ask for permission to install
        local response = vim.fn.input("I see that you don't have packer installed do you wanna installed? (y/n) ", "y")

        -- if not permisison end the function 
        if response ~= 'y' then
                return
        end

        -- default method to install packer
        os.execute("git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim")
        vim.cmd [[so ~/.config/nvim/lua/kraken/packer.lua]]
        vim.cmd [[PackerSync]]
end

return M.check()
