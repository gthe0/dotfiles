vim.pack.add({
  { src = 'https://github.com/nvim-mini/mini.pick', version = 'stable' },
  { src = 'https://github.com/nvim-mini/mini.extra', version = 'stable' },
})

require('mini.pick').setup()
require('mini.extra').setup()

local keymap  = vim.keymap
local builtin = require('mini.pick').builtin

keymap.set('n', '<leader>pf', function() builtin.files() end, { desc = "File Picker" })
keymap.set('n', '<leader>pb', function() builtin.buffers() end, { desc = "Buffer Picker" })

keymap.set('n', '<leader>pd', ":Pick diagnostic<CR>", { desc = "Show Diagnostics" })
keymap.set('n', '<leader>fd', ":Pick diagnostic<CR>", { desc = "Show Diagnostics" })

keymap.set('n', '<leader>fo', function() builtin.files({ default_split = 'vertical' }) end, { desc = "Open File in Vertical Split" })
keymap.set('n', '<leader>bo', function() builtin.buffers({ default_split = 'vertical' }) end, { desc = "Open Buffer in Vertical Split" })

keymap.set('n', '<leader>/', function() builtin.grep_live() end, { desc = "Live Grep" })

