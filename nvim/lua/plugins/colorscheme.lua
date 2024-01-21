local ok, _ = pcall(vim.cmd, 'colorscheme github_dark_colorblind')

if ok then
	vim.cmd.colorscheme "github_dark_colorblind"
else
	vim.cmd.colorscheme "desert"
end
