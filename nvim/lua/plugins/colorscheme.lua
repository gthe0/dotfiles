local ok, _ = pcall(vim.cmd.colorscheme , 'zenburn')

if ok then
	vim.cmd.colorscheme "zenburn"
else
	vim.cmd.colorscheme "desert"
end
