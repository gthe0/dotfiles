local mason_status,_ = pcall(require, "mason-lspconfig")
if not mason_status then
	return
end

require("mason-lspconfig").setup {
    ensure_installed = { "lua_ls", "rust_analyzer", "clangd" , "vimls" },
}

require("mason-lspconfig").setup_handlers {
	function (server_name) -- default handler (optional)
		require("lspconfig")[server_name].setup {
			on_attach = function(client)
			client.server_capabilities.semanticTokensProvider = nil
		end
		}
	end,
}
