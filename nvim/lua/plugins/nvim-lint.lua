-- linting
require('lint').linters_by_ft = {
  cpp = {'cpplint'},
}

-- I do not know if this works
vim.keymap.set("n", "<leader>l", function()
	require('lint').try_lint()
	end, { desc = "Trigger linting for current file" })
