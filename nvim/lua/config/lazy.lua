------------------------------------------------------------------------
--
-- lazy.nvim automatically lazy-loads Lua modules.
--
--  This means that if you have a plugin A that is lazy-loaded
--  and a plugin B that requires a module of plugin A,
--  then plugin A will be loaded on demand as expected.
--
-- For more information about lazy.nvim, type the Lazy command.
--
------------------------------------------------------------------------

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

-- lazy will search for the plugins inside the plugins directory
require("lazy").setup({
    {import = "plugins"},
    {import = "plugins.lsp"},
    change_detection = { notify = false }
})
