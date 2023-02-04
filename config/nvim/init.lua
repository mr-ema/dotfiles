--------------------------------------------------------------
-- HERE YOU SHOULD PUT ALL FILES YOU WANNA LOAD IN ORDER --
--------------------------------------------------------------
require("utils")
require("kraken")

-- Install And Setup lazy.vim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins", {
    lockfile = vim.fn.stdpath("config") .. "/shada/lazy-lock.json",
})
