return
{
    -- tokyonight
    {
        "folke/tokyonight.nvim",
        lazy = false,
        opts = { style = "moon" },

        -- Load tokyonight colorscheme after installing it
        config = function()
 --           vim.cmd.colorscheme "tokyonight"
        end
    },
    {
        "phha/zenburn.nvim",
        lazy = false,

        config = function()
        end
    },
    {
        "Mofiqul/vscode.nvim",
        lazy = false,

        config = function()
                require("vscode").setup()
                vim.cmd.colorscheme "vscode"
        end
    }
}
