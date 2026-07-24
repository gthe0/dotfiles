vim.pack.add({
    'https://github.com/stevearc/oil.nvim',
})

require("oil").setup()
vim.keymap.set("n", "<leader>o", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Source - https://stackoverflow.com/q/73611872
-- Posted by fabolous05, modified by community. See post 'Timeline' for change history
-- Retrieved 2026-07-23, License - CC BY-SA 4.0
vim.api.nvim_create_user_command('Ex','Oil', { desc = "Open parent directory" })
