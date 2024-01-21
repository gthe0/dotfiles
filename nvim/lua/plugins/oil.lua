local oil_status,oil = pcall(require,"oil")
if not oil_status then
	return
end

oil.setup()

-- Shortcut to Open Oil in pwd
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
