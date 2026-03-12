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

        keymap.set('n', '<leader>pf', builtin.find_files, {})
        keymap.set('n', '<leader>fd', builtin.diagnostics, {})
        keymap.set('n', '<leader>g', builtin.live_grep, {})
        keymap.set('n', '<leader>b', builtin.buffers, {})

    end
}
