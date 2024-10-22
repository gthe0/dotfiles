return
{
<<<<<<< HEAD
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
=======
  -- tokyonight
  {
    "folke/tokyonight.nvim",
    lazy = false,
    opts = { style = "moon" },

    -- Load tokyonight colorscheme after installing it
    config = function()
        vim.cmd.colorscheme "tokyonight"
    end
  },

>>>>>>> 6fc64b2df95b630a37e25eeff219ad10c98aa2db
}
