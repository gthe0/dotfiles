return
{
    {
        "Mofiqul/vscode.nvim",
        lazy = false,

        config = function()
                require("vscode").setup()
                require("vscode").load("dark")
        end
    }
}
