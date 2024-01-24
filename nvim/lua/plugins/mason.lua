-- Import telescope safely

local mason_status,mason = pcall(require, "mason")
if not mason_status then
	return
end

mason.setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    },
	max_concurrent_installers = 10,
})
