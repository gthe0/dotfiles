local keymap = vim.keymap

vim.g.mapleader = " "		-- Remapping Leader Key to space

keymap.set('n', 'gp', '<cmd>bprev<CR>', vim.opts) -- Go to previous buffer
keymap.set('n', 'gn', '<cmd>bnext<CR>', vim.opts) -- Go to next buffe
keymap.set('n', '<leader>bc', '<cmd>bdelete<CR>', vim.opts) -- Delete current buffer
