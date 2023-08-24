local M = {}

function M.map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function M.lsp_attach()
    return function(client, bufnr)
        if client.server_capabilities.document_formatting then
            vim.cmd([[
                          augroup LspFormatting
                          autocmd! * <buffer>
                          autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
                          augroup END
                        ]])
        end

        if client.server_capabilities.codelens then
            local codelens = vim.api.nvim_create_augroup("LSPCodeLens", { clear = true })
            vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "CursorHold" }, {
                group = codelens,
                callback = function()
                    vim.lsp.codelens.refresh()
                end,
                buffer = bufnr,
            })
        end

        vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", {})
        vim.api.nvim_buf_set_keymap(
            bufnr,
            "n",
            "<leader>clr",
            "<cmd>lua vim.lsp.stop_client(vim.lsp.get_active_clients())<cr>",
            {}
        )
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cd", "<cmd>lua vim.lsp.buf.type_definition()<cr", {})
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>hh", "<cmd>lua vim.lsp.buf.signature_help()<cr>", {})
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", {})
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<cr>", {})
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>k", "<cmd>lua vim.diagnostic.goto_next()<cr>", {})
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>j", "<cmd>lua vim.diagnostic.goto_prev()<cr>", {})
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>aa", "<cmd>lua vim.buf.code_action()<cr>", {})
    end
end

return M
