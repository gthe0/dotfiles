local luasnip_status,ls = pcall(require, "luasnip")
if not luasnip_status then
	return
end

ls.opts = { history = true, updateevents = "TextChanged,TextChangedI" }
require("luasnip.loaders.from_vscode").lazy_load { exclude = vim.g.vscode_snippets_exclude or {} }
require("luasnip.loaders.from_vscode").lazy_load { paths = vim.g.vscode_snippets_path or "" }
