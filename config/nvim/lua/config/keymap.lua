vim.keymap.set("n", "<leader>nrw", vim.cmd.Ex)

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf

        vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "[G]o to [D]efinition" })
        vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, { buffer = bufnr, desc = "[H]over Documentation" })
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "[R]e[n]ame" })
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "[C]ode [A]ction" })
        vim.keymap.set("n", "<leader>rf", vim.lsp.buf.references, { buffer = bufnr, desc = ":List [R]e[f]erences" })
        vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "[G]o to [I]mplementation" })  
    end,
})
