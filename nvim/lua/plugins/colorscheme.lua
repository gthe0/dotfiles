local ok, _ = pcall(vim.cmd, 'colorscheme ayu')

if ok then
	vim.cmd.colorscheme "ayu"
else
	vim.cmd.colorscheme "desert"
end
