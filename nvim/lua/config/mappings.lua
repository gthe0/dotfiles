local keymap = vim.keymap

mapleader = " "		-- Remapping Leader Key to space

keymap.set('n', 'gp', '<cmd>bprev<CR>', opts) -- Go to previous buffer
keymap.set('n', 'gn', '<cmd>bnext<CR>', opts) -- Go to next buffe
keymap.set('n', '<leader>bd', '<cmd>bdelete<CR>', opts) -- Delete current buffer
