-- Import conform safely
local conform_status, conform = pcall(require, "conform")
if not conform_status then
	return
end

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
	cpp = {"clang-format"},
	java = {"google-java-format"},
    python = { "isort" },
    javascript = { { "prettierd", "prettier" } },
  },
})

conform.formatters.clangformat = {
    prepend_args = {"--style={IndentWidth:4}"},

}

vim.keymap.set({ "n", "v", "i" }, "<M-F>", function()
	conform.format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 1000,
	})
end ,{ desc = "Format file or range (in visual mode)" })

