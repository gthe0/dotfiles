-- Leader key
vim.g.mapleader = " "
vim.g.localleader = "\\"

-- Move region up/down and autoformat
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv")

-- Move line up/down in Normal Mode (VS Code style)
vim.keymap.set("n", "<M-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<M-k>", ":m .-2<CR>==", { desc = "Move line up" })

-- Create a vertical split
vim.keymap.set("n", "<leader>vs", ":vsplit<CR>")

-- Go to prev/next diagnostics and open a float
vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "previous diagnostics" })
vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count =  1, float = true }) end, { desc = "next diagnostics" })

-- One shortcut
vim.keymap.set({"n","v","i"}, "<S-F8>", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "previous diagnostics" })
vim.keymap.set({"n","v","i"}, "<F8>",   function() vim.diagnostic.jump({ count =  1, float = true }) end, { desc = "next diagnostics" })

-- Open file manager
vim.keymap.set("n", "<leader>o", ":Ex<CR>", { desc = "Open File Manager"})
