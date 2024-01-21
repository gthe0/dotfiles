-- Import lspconfig safely
local treesitter_status, treesitter = pcall(require, "nvim-treesitter.configs")
if not treesitter_status then
	return
end

treesitter.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "cpp", "glsl" },

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

