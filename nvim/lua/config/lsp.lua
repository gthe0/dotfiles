vim.opt.completeopt = { "menuone", "noselect", "popup" }

vim.lsp.enable({
    "clangd",
    "cmake",
    "glslls",
    "lua-language-server",
    "vim-language-server",
    "bash-language-server"
})

-- Trigger autocompletion
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        if client:supports_method('textDocument/implementation') then
            -- Keymaps (only the ones you asked to keep)
            local opts = { buffer = bufnr, silent = true }
            local keymap = vim.keymap

            keymap.set("n", "K", vim.lsp.buf.hover, opts)
            keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
            keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
            keymap.set("n", "gr", vim.lsp.buf.references, opts)
            keymap.set("n", "<leader>t", vim.lsp.buf.type_definition, opts)
            keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

            --  vertical split‑definition
            keymap.set("n", "<leader>d", function()
                if vim.fn.winnr("$") > 1 then
                    vim.cmd([[vsplit]])
                    vim.lsp.buf.definition()
                    local current_buf = vim.api.nvim_get_current_buf()

                    vim.cmd("wincmd c")
                    vim.cmd("wincmd w")

                    vim.api.nvim_set_current_buf(current_buf)
                else
                    vim.cmd([[vsplit]])
                    vim.lsp.buf.definition()
                end
            end, opts)
        end

        -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, args.buf, {
                autotrigger = true,
                convert = function(item)
                    return { abbr = item.label:gsub("%b()", "") }
                end,
            })
        end
    end,
})

-- Go to prev/next diagnostics and open a float
vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "previous diagnostics" })
vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count =  1, float = true }) end, { desc = "next diagnostics" })

-- Enable and attach

