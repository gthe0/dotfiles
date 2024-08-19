return {
	-- nvim-lsp configuration
	"neovim/nvim-lspconfig",

	dependencies = { "j-hui/fidget.nvim" },

	config = function()
		-- Load fidget plugin
		require("fidget").setup({})

		local lsp = vim.lsp
		local keymap = vim.keymap
		local diagnostic = vim.diagnostic

		lsp.set_log_level("error") -- Specify Log level
		lsp.telemetry = false -- Disable telemetry

		-- Use LspAttach autocommand to only map the following keys
		-- after the language server attaches to the current buffer
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local cmp_status, _ = pcall(require, "cmp")

				if not cmp_status then
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
				end

				local opts = { buffer = ev.buf, silent = true }

				--------------------------------------------------------------------
				-- Keybinds for 65% =< Keyboards
				--------------------------------------------------------------------
				keymap.set("n", "K", lsp.buf.hover, opts)
				keymap.set("n", "gd", lsp.buf.definition, opts)
				keymap.set("n", "gD", lsp.buf.declaration, opts)
				keymap.set("n", "gi", lsp.buf.implementation, opts)
				keymap.set("n", "gr", lsp.buf.references, opts)
				keymap.set("n", "<leader>d", lsp.buf.type_definition, opts)
				keymap.set("n", "<leader>rn", lsp.buf.rename, opts)
				keymap.set("n", "GD", function()
                    if vim.fn.winnr("$") > 1  then

                        vim.cmd([[ vsplit ]])
                        lsp.buf.definition()
                        local current_buf = vim.api.nvim_get_current_buf()

                        -- Close the buffer...
                        vim.cmd('wincmd c')
                        -- ...and switch to the next split
                        vim.cmd('wincmd w')

                        -- Open the current buffer in the next split
                        vim.api.nvim_set_current_buf(current_buf)
                    else
                        vim.cmd([[ vsplit ]])
                        lsp.buf.definition()
                    end
				end, opts)
                keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
			end,
		})
		------------------------------------------------------------------------
		-- Diagnostic settings
		------------------------------------------------------------------------

		-- disable virtual_text (inline) diagnostics and use floating window
		-- format the message such that it shows source, message and
		-- the error code. Show only the diagnostic under the cursor.
		-- Spawn the floating window by pressing <leader>e.
		diagnostic.config({
			virtual_text = false,
			update_in_insert = true,
			underline = true,
			float = {
				scope = "line",
				border = "single",
				header = "",
				prefix = "",
			},
		})

		-- Diagnostics mappings
		keymap.set("n", "<leader>e", diagnostic.open_float)
		keymap.set("n", "[d", diagnostic.goto_prev)
		keymap.set("n", "]d", diagnostic.goto_next)

	end,
}
