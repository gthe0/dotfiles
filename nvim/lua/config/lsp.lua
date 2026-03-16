vim.o.complete = ".,b"
vim.o.completeopt = "menuone,noselect,popup"
vim.o.pumheight = 8

vim.lsp.enable({
    "clangd",
    "cmake",
    "glslls",
    "lua_ls",
    "vimls",
    "bashls",
    "jdtls"
})

-- nvim diagnostics enable
vim.diagnostic.config({
    update_in_insert = true,
    severity_sort = true,
    float = {
        border = "rounded",
        source = true,
    }
})

-- Go to prev/next diagnostics and open a float
vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "previous diagnostics" })
vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count =  1, float = true }) end, { desc = "next diagnostics" })

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
            map("gD", vim.lsp.buf.declaration, "Goto Declaration")
            map("<leader>la", vim.lsp.buf.code_action, "Code Action")
            map("<leader>lr", vim.lsp.buf.rename, "Rename all references")
            map("<leader>lf", vim.lsp.buf.format, "Format")

            map("K", vim.lsp.buf.hover, "Hover Documentation")
            map("gd", vim.lsp.buf.definition, "LSP goto definition")
            map("gD", vim.lsp.buf.declaration, "LSP goto declaration")
            map("gi", vim.lsp.buf.implementation, "LSP show implemenations")
            map("gr", vim.lsp.buf.references, "LSP show references")
            map("<leader>t", vim.lsp.buf.type_definition, "LSP show type definitions")
            map("<leader>rn", vim.lsp.buf.rename, "LSP Rename")
            map("<leader>d", "<cmd>vsplit | lua vim.lsp.buf.definition()<cr>", "Goto Definition in Vertical Split")

        end

        -- Enable auto-completion.
        if client:supports_method('textDocument/completion') then

            local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
            client.server_capabilities.completionProvider.triggerCharacters = chars

            vim.lsp.completion.enable(true, client.id, args.buf, {autotrigger = true})
        end
    end
})
