vim.g.start_time = vim.uv.hrtime()

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require('config.options')
require('config.keymap')

require('config.lazy')

vim.lsp.enable({ "lua_ls", "astro", "tailwindcss", "ts_ls", "nil" })
