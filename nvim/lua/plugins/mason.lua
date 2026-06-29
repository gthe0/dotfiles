vim.pack.add ({
    -- Mason used as lsp, formater, linter etc installer
	{ src = 'https://github.com/mason-org/mason.nvim' }
})

local mason = require("mason")

-- mason setup and ui components
mason.setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    },

    -- Number concurrent installations
    max_concurrent_installers = 5,
})
