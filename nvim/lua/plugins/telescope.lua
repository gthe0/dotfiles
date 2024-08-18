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
            keymap.set('n', '<C-p>', builtin.git_files, {})
            keymap.set('n', '<leader>pws', function()
                local lword = fn.expand("<cword>")
                builtin.grep_string({ search = word })
            end)
            keymap.set('n', '<leader>pWs', function()
                local word = fn.expand("<cWORD>")
                builtin.grep_string({ search = word })
            end)
            keymap.set('n', '<leader>ps', function()
                builtin.grep_string({ search = fn.input("Grep > ") })
            end)
            keymap.set('n', '<leader>vh', builtin.help_tags, {})

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
            keymap.set('n','<leader>u',"<cmd>Telescope undo<cr>")

        end
    }
}
