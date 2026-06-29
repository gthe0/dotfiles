vim.pack.add({
    -- Telescope Plugin
    'https://github.com/nvim-telescope/telescope.nvim',
})

-- Telescope keybinds
local keymap  = vim.keymap
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')

-- create a picker which does vertical split
local function with_vsplit(picker_func, opts)
    opts = opts or {}

    -- Inject the vertical split mapping override
    opts.attach_mappings = function(_, map)
        map('i', '<CR>', actions.select_vertical)
        map('n', '<CR>', actions.select_vertical)
        return true
    end

    -- Return a function so keymap.set can call it properly
    return function()
        picker_func(opts)
    end
end

-- File pickers
keymap.set('n', '<leader><leader>', builtin.find_files, { desc = "File Picker" })
keymap.set('n', '<leader>pf',       builtin.find_files, { desc = "File Picker" })
keymap.set('n', '<leader>fr',       builtin.oldfiles, { desc = "Find recent Files" })
keymap.set('n', '<leader>fo',       with_vsplit(builtin.find_files), { desc = "Open File in Vertical Split" })

-- Diagnostics and Search
keymap.set('n', '<leader>fd', builtin.diagnostics, {})
keymap.set('n', '<leader>/', builtin.live_grep, {})

-- Buffer related stuff
keymap.set('n', '<leader>bb', builtin.buffers, { desc = "Buffer Picker" })
keymap.set('n', '<leader>bo', with_vsplit(builtin.buffers), { desc = "Open Buffer in Vertical Split" })
