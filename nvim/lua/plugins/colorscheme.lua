-- Install the theme
vim.pack.add({
    {src = 'https://github.com/Mofiqul/vscode.nvim'},
    {src = 'https://github.com/Mofiqul/adwaita.nvim'}
})

-- Load it
vim.g.adwait_darker = true
vim.cmd('colorscheme adwaita')

