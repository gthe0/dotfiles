-- Close some buffers using <q>. 
-- Won't need to record macros there probably.
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
  pattern = {
    "checkhealth",
    "help",
    "lspinfo",
    "qf",
    "git",
    "trouble",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      local close_buffer = function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end
      vim.keymap.set("n", "q", close_buffer, { buffer = event.buf, silent = true, desc = "Close buffer", nowait = true })
      vim.keymap.set("n", "<esc>", close_buffer,
        { buffer = event.buf, silent = true, desc = "Close buffer", nowait = true })
    end)
  end,
})
