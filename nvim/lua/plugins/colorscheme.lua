local ok, _ = pcall(vim.cmd.colorscheme , 'vscode')

if ok then
	vim.cmd.colorscheme "vscode"
else
	vim.cmd.colorscheme "desert"
end
