--------------------------------------------------------------------------------------------------
-- BASIC NEOVIM SETTINGS 
--
--	If a setting is unclear refer to the manual by typing h <UNCLEAR_SETTING>
--------------------------------------------------------------------------------------------------

local opt = vim.opt

-- Line enumeration
opt.number = true -- Line number

-- Search Options
opt.hlsearch = true -- Highlight search results
opt.incsearch = true -- Real-Time search results as the User Types
opt.inccommand = "split" --Real-Time effect of commands related to searching

-- Case Insensitive Searching
opt.ignorecase = true -- Ignore Case while searching UNLESS /C or Capital later is added 
opt.smartcase  = true -- Prioritizes search results based of the capitalization
opt.infercase = true -- Infers the Case based of Search results

-- Windows Options
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.scrolloff = 5 -- Minimal number of screen lines to keep above and below the cursor.

-- Tab Options
opt.expandtab = true -- Use Spaces on pressing Tab key
opt.softtabstop = 4 -- Makes the tab be 4 spaces long
opt.shiftwidth = 4
opt.tabstop = 4

-- WildMenu Options
opt.wildmode = "full:list,full" -- Better tab completion
opt.pumheight = 5
opt.wildignorecase = true -- Case insensitive command searching

-- Apperance
opt.termguicolors = true -- True color support

-- Fuzzy Find settings
opt.path:append("**")

-- General Settigns
opt.backspace = { "start", "eol", "indent" } -- Makes backspace go to the upper line if current line is fully deleted
opt.swapfile = false -- Disable swapfile creation
opt.shortmess:append({ W = true, I = true, c = true, C = true }) -- Do not show some completion messages
opt.hidden = true -- Makes the buffers that are not displayed hidden
opt.encoding = "utf-8" -- Changes the encoding to UTF-8
opt.timeoutlen = 400 -- The time that nvim waits for next command input
