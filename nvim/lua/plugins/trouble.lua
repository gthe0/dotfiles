return {
    "folke/trouble.nvim",

    -- Trouble configuration after installation
    config = function()

        local trouble = require("trouble")

        -- Trouble settings (disable icons)
        trouble.setup({})

        -- Trouble keymaps
    end

}
