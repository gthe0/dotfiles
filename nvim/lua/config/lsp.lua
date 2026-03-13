vim.o.complete = ".,o"
vim.o.completeopt = { "fuzzy", "menuone", "noselect", "popup" }
vim.o.autocomplete = true
vim.o.pumheight = 8

vim.lsp.enable({
    "clangd",
    "cmake",
    "glslls",
    "lua-language-server",
    "vim-language-server",
    "bash-language-server"
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

