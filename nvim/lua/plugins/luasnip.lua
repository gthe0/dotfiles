local luasnip_status,ls = pcall(require, "luasnip")
if not luasnip_status then
	return
end

ls.opts = { history = true, updateevents = "TextChanged,TextChangedI" }
require("luasnip.loaders.from_vscode").lazy_load()
