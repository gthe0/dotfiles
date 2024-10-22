return {

    -- Mason used as lsp, formater, linter etc installer
    {
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
    },

    -- Mason lsp config
    {
        "williamboman/mason-lspconfig.nvim",

        config = function()

            local mason_lsp = require("mason-lspconfig")

            mason_lsp.setup({
                -- list of servers for mason to install
                ensure_installed = {
                    "clangd",
                    "vimls",
                    "lua_ls",
                    "rust_analyzer",
                    "marksman",
                    "texlab",
                    "jsonls",
                    "taplo"
                }
            })

            local lspconfig_status, lspconfig = pcall(require, "lspconfig")
            local cmp_lsp_status, cmp_lsp = pcall(require, "cmp_nvim_lsp")

            -- Import lspconfig safely
            if not lspconfig_status or not cmp_lsp_status then
                return
            end

            -- The capabilities of lsp handlers
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                cmp_lsp.default_capabilities())

            -- mason lsp settings
            mason_lsp.setup({

                -- here we define the handlers/behaviour
                -- of the various lsp servers
                handlers = {

                    -- Default behaviour/handler
                    function(server_name) 
                        lspconfig[server_name].setup {
                            capabilities = capabilities
                        }
                    end,

                    -- Handler for the lua language server
                    ["lua_ls"] = function()

                        lspconfig.lua_ls.setup {
                            -- Capablities of the lua server
                            capabilities = capabilities,

                            settings = {
                                Lua = {
                                    runtime = {
                                        -- Tell the language server which version of Lua you're using
                                        -- (most likely LuaJIT in the case of Neovim)
                                        version = "LuaJIT",
                                    },
                                    diagnostics = {
                                        globals = {
                                            "vim",
                                            "require",
                                        },
                                    },
                                    workspace = {
                                        library = vim.api.nvim_get_runtime_file("", true),
                                    },
                                },
                            }
                        }
                    end
                }
            })
        end
    }
}

