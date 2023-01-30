require("typescript").setup({
	server = { -- pass options to lspconfig's setup method
		on_attach = function(client, bufnr)
			client.server_capabilities.document_formatting = false
			client.server_capabilities.document_range_formatting = false

			local ts_utils = require("nvim-lsp-ts-utils")
			ts_utils.setup({ import_all_timeout = 5000, enable_formatting = false })
			ts_utils.setup_client(client)

			-- buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
			-- buf_map(bufnr, "n", "gi", ":TSLspRenameFile<CR>")
			-- buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")

			return lsp_attach()(client, bufnr)
		end,
	},
})
