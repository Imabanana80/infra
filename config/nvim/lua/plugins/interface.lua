return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {{ "<leader>fk", function() require("which-key").show({ global = false }) end, desc = "[F]ind [K]eymaps"}},
    },

    {
        "petertriho/nvim-scrollbar",
        opts = {}
    },
    {
        "uga-rosa/ccc.nvim",
        opts = {
            highlighter = {
                auto_enable = true,
                lsp = true,
	        },
        }
    },
    {
        'nvim-mini/mini.pairs',
        version = '*',
        opts = {}
    },
    {
        'nvim-mini/mini.starter',
        version = "*",
        config = function ()
            local starter = require("mini.starter")

            local logo =
[[
│ ╲ ││
││╲╲││
││ ╲ │
]]

            local header = function()
              local v = vim.version()
              return logo .. '\nNVIM v' .. v.major .. '.' .. v.minor .. '.' .. v.patch
            end

            local footer = function()
              local ms = (vim.uv.hrtime() - vim.g.start_time) / 1e6
              local ok = pcall(require, 'lazy')
              local count = ok and require('lazy').stats().count or 0
              return ('Loaded with %d plugins in %.0fms'):format(count, ms)
            end

            starter.setup({
            header = header,
            items = {
                starter.sections.recent_files(8, true),
            },
            footer = footer,
            content_hooks = {
                starter.gen_hook.adding_bullet('█ '),
                starter.gen_hook.aligning('center', 'center'),
            },
            })

            local C = require('catppuccin.palettes').get_palette('mocha')
            vim.api.nvim_set_hl(0, 'MiniStarterHeader', { fg = C.pink })
            vim.api.nvim_set_hl(0, 'MiniStarterSection',{ fg = C.surface2})
            vim.api.nvim_set_hl(0, 'MiniStarterItem',{ fg = C.subtext1})
            vim.api.nvim_set_hl(0, 'MiniStarterItemBullet',{ fg = C.surface0})
            vim.api.nvim_set_hl(0, 'MiniStarterCurrent',{ fg = C.subtext1 })
            vim.api.nvim_set_hl(0, 'MiniStarterItemPrefix',{ fg = C.red})
            vim.api.nvim_set_hl(0, 'MiniStarterQuery',{ fg = C.red, bold = true })
            vim.api.nvim_set_hl(0, 'MiniStarterFooter', { fg = C.green})
        end
    },
}
