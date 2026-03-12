return
{
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
