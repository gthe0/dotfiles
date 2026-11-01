vim.o.complete = ".,b"
vim.o.completeopt = "menuone,noinsert,popup"
vim.o.pumheight = 8

vim.lsp.enable({
        "clangd",
        "cmake",
        "glslls",
        "vimls",
        "jdtls",
        "bashls",
        "lua_ls",
        "basedpyright"
})

-- nvim diagnostics enable
vim.diagnostic.config({
        update_in_insert = false,
        severity_sort = true,
        float = {
                border = "rounded",
                source = true,
        }
})

-- <TAB> completion
local function accept_completion()
        if vim.fn.pumvisible() == 1 then
                return "<C-y>"
        end
        return "<Tab>"
end

-- Generic lsp behaviour
vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(args)
                local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

                if client:supports_method('textDocument/implementation') then
                        local map = function(keys, func, desc)
                                vim.keymap.set("n", keys, func, { buffer = args.buf, desc = "LSP: " .. desc })
                        end

                        -- defaults:
                        -- https://neovim.io/doc/user/news-0.11.html#_defaults
                        map("gl", vim.diagnostic.open_float, "Open Diagnostic Float")
                        map("gs", vim.lsp.buf.signature_help, "Signature Documentation")
                        map("<leader>la", vim.lsp.buf.code_action, "Code Action")
                        map("<leader>lr", vim.lsp.buf.rename, "Rename all references")
                        map("<leader>lf", vim.lsp.buf.format, "Format")

                        -- Go to defintion
                        map("K", vim.lsp.buf.hover, "Hover Documentation")
                        map("gd", vim.lsp.buf.definition, "LSP goto definition")
                        map("gD", vim.lsp.buf.declaration, "LSP goto declaration")
                        map("gi", vim.lsp.buf.implementation, "LSP show implemenations")
                        map("gr", vim.lsp.buf.references, "LSP show references")
                        map("gt", vim.lsp.buf.type_definition, "LSP show type definitions")
                end

                -- Enable auto-completion.
                if client:supports_method('textDocument/completion') then
                        local excluded = {
                                [string.byte("?")] = true,
                                [string.byte(",")] = true,
                                [string.byte(";")] = true,
                                [string.byte("{")] = true,
                                [string.byte("(")] = true,
                                [string.byte(")")] = true,
                                [string.byte("'")] = true,
                                [string.byte("}")] = true,
                                [string.byte('"')] = true,
                                [string.byte("&")] = true,
                                [string.byte("!")] = true,
                        }

                        -- autotrigger on some chars
                        local chars = {}
                        for i = 32, 126 do
                                if not excluded[i] then
                                        table.insert(chars, string.char(i))
                                end
                        end

                        -- client capabilities
                        client.server_capabilities.completionProvider.triggerCharacters = chars
                        vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })

                        -- vscode like behaviour for completion
                        vim.keymap.set("i", "<Tab>", accept_completion, {
                                buffer = args.buf,
                                expr = true,
                                replace_keycodes = true,
                        })
                end
        end
})
