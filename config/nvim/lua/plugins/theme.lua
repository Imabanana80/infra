return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                integrations = {
                    indent_blankline = {
                        enabled = true,
                        colored_indent_levels = true,
                    },
                },
            })
            vim.cmd.colorscheme("catppuccin-mocha")
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "catppuccin-mocha",
                },
            })
        end,
    }
}


