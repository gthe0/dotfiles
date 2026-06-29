return {
    -- Telescope Plugin
    "nvim-telescope/telescope.nvim",

    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install'
        },
    },

    -- Telescope configuration
    config = function()

        -- Load telescope extension first...
        require('telescope').setup({ })

        -- Telescope keybinds
        local keymap = vim.keymap
        local builtin = require('telescope.builtin')

        -- File pickers
        keymap.set('n', '<leader>pf', builtin.find_files, { desc = "File Picker"})
        keymap.set('n', '<leader>ff', function() 
            builtin.find_files({ jump_type = "vsplit" }) 
        end, { desc = "Find Files in Vertical Split" })

        -- Diagnostics and Search
        keymap.set('n', '<leader>fd', builtin.diagnostics, {})
        keymap.set('n', '<leader>/' , builtin., {})

        -- Buffer related stuff
        keymap.set('n', '<leader>bb', builtin.buffers, { desc = "Buffer Picker"})
        keymap.set('n', '<leader>bo', function() 
            builtin.buffers({ jump_type = "vsplit" }) 
        end, { desc = "Buffers in Vertical Split" })
    end
}
