-- Install the theme
vim.pack.add({
    {
        src = 'https://github.com/Mofiqul/vscode.nvim'
    }
})

-- Load it
require("vscode").setup()
require("vscode").load("dark")

