local M = {
"williamboman/mason.nvim",
config = function()
	require("mason").setup({
		ui = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗"
		}
	})
	end,
}



return { M }
