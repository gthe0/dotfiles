local luasnip_status,ls = pcall(require, "luasnip")
if not luasnip_status then
	return
end

local keymap = vim.keymap

keymap.set({"i"}, "<Tab>", function() ls.expand() end, {silent = true})
keymap.set({"i", "s"}, "<Tab>", function() ls.jump( 1) end, {silent = true})
keymap.set({"i", "s"}, "<S-Tab>", function() ls.jump(-1) end, {silent = true})

keymap.set({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})

require("luasnip.loaders.from_vscode").lazy_load()
