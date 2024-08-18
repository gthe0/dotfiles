return  {

    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",

    dependencies = { "rafamadriz/friendly-snippets" },

    config = function()

        local ls = require("luasnip")

        --- Define LSP default behaviour
        ls.opts = { history = true, updateevents = "TextChanged,TextChangedI" }
        require("luasnip.loaders.from_vscode").lazy_load { exclude = vim.g.vscode_snippets_exclude or {} }
        require("luasnip.loaders.from_vscode").lazy_load { paths = vim.g.vscode_snippets_path or "" }
    end
}
