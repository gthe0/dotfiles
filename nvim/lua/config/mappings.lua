local keymap = vim.keymap

vim.g.mapleader = " "		-- Remapping Leader Key to space

keymap.set('n', '<leader>cd', '<cmd>lcd%:h<CR>', vim.opts) -- Change current working directory to the current file
keymap.set('n', '<leader>b', '<cmd>:buffers<CR>:buffer<Space>', vim.opts) -- Display buffer list and then select the one that you want to

