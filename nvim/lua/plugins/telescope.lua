return {
    -- Telescope Plugin
    {
        "nvim-telescope/telescope.nvim",

        tag = "0.1.5",

        -- Telescope configuration
        config = function()

            -- Load telescope extension first...
            require('telescope').setup({ })

            -- Telescope keybinds
            local keymap = vim.keymap
            local builtin = require('telescope.builtin')

            keymap.set('n', '<leader>pf', builtin.find_files, {})
            keymap.set('n', '<leader>fd', builtin.diagnostics, {})
            keymap.set('n', '<leader>g', builtin.live_grep, {})
            keymap.set('n', '<leader>b', builtin.buffers, {})

        end
    },
    -- Telescope Undo plugin
    {
        "debugloop/telescope-undo.nvim",

        config = function()

            local keymap = vim.keymap

            -- Load undo extension
            require('telescope').load_extension("undo")

            -- Undo Tree through telescope
            keymap.set('n','<leader>u',"<cmd>Telescope undo<cr><ESC>")

        end
    }
}
