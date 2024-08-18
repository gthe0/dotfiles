return
{
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

}
