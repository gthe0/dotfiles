return {
    -- Mason used as lsp, formater, linter etc installer
        "williamboman/mason.nvim",
        config = function()

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
        end
}

