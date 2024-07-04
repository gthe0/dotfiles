require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
	cpp = {"clang-format"},
    python = { "isort", "black" },
    javascript = { { "prettierd", "prettier" } },
  },
})


vim.keymap.set({ "n", "v", "i" }, "<M-F>", function()
	require("conform").format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 1000,
	})
end ,{ desc = "Format file or range (in visual mode)" })

