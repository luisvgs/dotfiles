local lsp_attach = require("functions").lsp_attach
local buf_map = function(bufnr, mode, lhs, rhs, opts)
	vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
		silent = true,
	})
end

require("typescript").setup({
	disable_commands = false, -- prevent the plugin from creating Vim commands
	disable_formatting = false, -- disable tsserver's formatting capabilities
	debug = false, -- enable debug logging for commands
	server = { -- pass options to lspconfig's setup method
		settings = { documentFormatting = true },
		on_attach = function(clients, bufnr)
			local opts = { silent = true }
			buf_map(bufnr, "n", "goi", ":TypescriptOrganizeImports<CR>", opts)
			buf_map(bufnr, "n", "grf", ":TypescriptRenameFile<CR>", opts)
			buf_map(bufnr, "n", "gam", ":TypescriptAddMissingImports<CR>", opts)
			buf_map(bufnr, "n", "gru", ":TypescriptRemoveUnused<CR>", opts)
			lsp_attach(clients, bufnr)
		end,
	},
})
