-- Import lint safely
local lint_status, lint = pcall(require, 'lint')
if not lint_status then
	return
end

-- Match linters to languages
lint.linters_by_ft = {
  cpp = {'cpplint'},
  java = {'checkstyle'},
}

-- Funtion used to call the linters
vim.keymap.set("n", "<leader>l", function()
	lint.try_lint()
	end, { desc = "Trigger linting for current file" })
