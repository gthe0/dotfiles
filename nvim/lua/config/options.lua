--------------------------------------------------------------------------------------------------
-- BASIC NEOVIM SETTINGS 
--
--	If a setting is unclear refer to the manual by typing h <UNCLEAR_SETTING>
--------------------------------------------------------------------------------------------------

vim.g.mapleader = " "		-- Remapping Leader Key to space

-- Line enumeration
vim.opt.number = true -- Line number
vim.opt.relativenumber = true -- Relative Line number

-- Search Options
vim.opt.ignorecase = true -- Ignore Case while searching UNLESS /C or Capital later is added 
vim.opt.smartcase  = true -- Prioritizes search results based of the capitalization

-- Windows Options
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current
vim.opt.scrolloff = 8 -- Minimal number of screen lines to keep above and below the cursor.

-- Tab Options
vim.opt.expandtab = false -- Use Tab character on pressing Tab key
vim.opt.softtabstop = 2 -- Makes the tab be 2 spaces long
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

-- WildMenu Options
vim.opt.wildmode = "full:list,full" -- Better tab completion
vim.opt.pumheight = 10
vim.opt.timeoutlen = 300 -- The time that nvim waits for next command input

-- UI
vim.opt.termguicolors = true -- True color support

-- General Settigns
vim.opt.backspace = { "start", "eol", "indent" } -- Makes backspace go to the upper line if current line is fully deleted
vim.opt.shortmess:append({ W = true, I = true, c = true, C = true }) -- Do not show some completion messages
vim.opt.hidden = true -- Makes the buffers that are not displayed hidden
vim.opt.encoding = "utf-8" -- Changes the encoding to UTF-8
