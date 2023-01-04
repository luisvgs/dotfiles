local M = {}
local lsp_status = require("lsp-status")

function M.lsp_attach(client, bufnr)
	if client.server_capabilities.documentHighlightProvider then
		vim.api.nvim_exec(
			[[
                augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                autocmd CursorHold * lua vim.diagnostic.open_float(nil, {focus=false})
                augroup END
                ]],
			false
		)
	end
	if client.server_capabilities.document_formatting then
		vim.cmd([[
                augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
                augroup END
                ]])
	end
	lsp_status.on_attach(client)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gk", "<cmd>lua vim.lsp.buf.hover()<cr>", {})
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cd", "<cmd>lua vim.lsp.buf.definition()<cr>", {})
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", {})
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", {})
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cn", "<cmd>lua vim.lsp.diagnostic.goto_next()<cr>", {})
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cp", "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>", {})
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<cr>", {})
	vim.api.nvim_buf_set_keymap(bufnr, "i", "<C-h>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", {})
end

return M
