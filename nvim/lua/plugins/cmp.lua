return {

    "hrsh7th/nvim-cmp",

    -- Dependencies for nvim-cmp
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "saadparwaiz1/cmp_luasnip"
    },

    config = function()

        -- Import safely the cmp plugin
        local cmp_status,cmp = pcall(require, "cmp")
        if not cmp_status then
            return
        end

        local luasnip_status, luasnip = pcall(require, "luasnip")

        -- Check if luasnip was installed to configure things
        if not luasnip_status then
            return
        end

        cmp.setup({

            -- Disable autocompletion inside comments
            enabled = function ()

                local context = require 'cmp.config.context'

                if vim.api.nvim_get_mode().mode == 'c' then
                    return true
                else
                    return not context.in_treesitter_capture("comment")
                    and not context.in_treesitter_capture("Comment")
                end
            end,

            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },

            mapping = cmp.mapping.preset.insert({
                ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                ["<Down>"]= cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.confirm({select = true})
                    elseif require("luasnip").expand() then
                        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand", true, true, true), "")
                    else
                        fallback()
                    end
                end
                    ,{"s","i",}
                )
            }),

            sources = cmp.config.sources({
                { name = 'nvim_lsp_signature_help' },
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = "path" },
            },
                {
                    { name = 'buffer' },
                })
        })

        cmp.setup.filetype('gitcommit', {
            sources = cmp.config.sources({
                { name = 'git' },
            },
                {
                    { name = 'buffer' },
                })
        })

        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })

        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                    { name = 'cmdline' }
                })
        })
    end
}
