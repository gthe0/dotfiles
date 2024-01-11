local mason_status,mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_status then
	return
end

mason_lspconfig.setup()
