-- Import lspconfig safely
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

vim.diagnostic.config({
  virtual_text = false
})

-- Global mappings.
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

-- Visual Studio like diagnostics
vim.keymap.set('n', '<S-F8>', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<F8>', vim.diagnostic.goto_next)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)

	local cmp_status,_ = pcall(require, "cmp")

	if not cmp_status then
    -- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
	end

	local opts = { buffer = ev.buf }

	--------------------------------------------------------------------
	-- Visual Studio like keybinds
	--------------------------------------------------------------------
	vim.keymap.set({ 'n', 'v', 'i' }, '<S-F12>', vim.lsp.buf.references, opts)
	vim.keymap.set({ 'n', 'v', 'i' }, '<M-F12>', vim.lsp.buf.declaration, opts)
	vim.keymap.set({ 'n', 'v', 'i' }, '<F12>', vim.lsp.buf.definition, opts)
	vim.keymap.set({ 'n', 'v', 'i' }, '<F2>', vim.lsp.buf.rename, opts)
	vim.keymap.set({ 'n', 'v', 'i' }, '<F3>', vim.lsp.buf.hover, opts)
	vim.keymap.set({ 'n', 'v', 'i' }, '<C-F12>',  function()
		vim.cmd([[ vsplit ]])
		vim.lsp.buf.definition()
  end, opts)

	--------------------------------------------------------------------
	-- Keybinds for 65% =< Keyboards
	--------------------------------------------------------------------
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
	vim.keymap.set('n', '<space>d', vim.lsp.buf.type_definition, opts)
	vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
	vim.keymap.set('n', 'GD',  function()
		vim.cmd([[ vsplit ]])
		vim.lsp.buf.definition()
  end, opts)

	--------------------------------------------------------------------
	-- WorkSpace Folders
	--------------------------------------------------------------------
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
end
})

------------------------------------------------------------------------
-- Lua lsp recognizes vim.globals
------------------------------------------------------------------------
lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = {
          'vim',
          'require'
        },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
