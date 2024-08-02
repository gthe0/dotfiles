local autopairs_status,_ = pcall(require, "nvim-autopairs")
if not autopairs_status then
	return
end

require("nvim-autopairs").setup { }

