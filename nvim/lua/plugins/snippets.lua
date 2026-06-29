vim.pack.add({
    { src = 'https://github.com/rafamadriz/friendly-snippets'},
    { src = 'https://github.com/nvim-mini/mini.snippets'}
})

-- Let the snippets reside inside the configuration
local global_snippets_path = vim.fn.stdpath('config') .. '/snippets/global.json'
local gen_loader = require('mini.snippets').gen_loader

require('mini.snippets').setup({
  snippets = {
    -- Load custom file with global snippets first 
    gen_loader.from_file(global_snippets_path),

    -- Load snippets based on current language by reading files from
    -- "snippets/" subdirectories from 'runtimepath' directories.
    gen_loader.from_lang(),
  },
})
