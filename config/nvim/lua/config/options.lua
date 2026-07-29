-- system
vim.g.have_nerd_font = true
vim.opt.clipboard = "unnamedplus"
vim.opt.history = 255
vim.opt.undofile = true
vim.opt.mouse = ""

-- ui
vim.diagnostic.config({virtual_text = true})
vim.opt.title = true
vim.opt.showmode = false
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.wrap = false
vim.opt_local.wrap = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.splitkeep = "cursor"
vim.opt.termguicolors = true

-- sidebar
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"

-- indent
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.breakindent = true

-- search
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smarttab = true

--misc
vim.opt.showcmd = true
vim.opt.inccommand = "split"

--lsp
vim.lsp.inlay_hint.enable()
