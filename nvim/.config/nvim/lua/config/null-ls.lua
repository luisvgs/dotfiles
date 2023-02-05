local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	debug = false,
	debounce = 150,
	update_in_insert = false,
	sources = {
		-- null_ls.builtins.diagnostics.eslint_d.with({
		-- 	diagnostics_format = "[#{s}] #{m}\n(#{c})",
		-- }),
		null_ls.builtins.formatting.prettierd.with({
			filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
		}),
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.shfmt,
		-- null_ls.builtins.formatting.scalafmt,
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
		require("functions").lsp_attach(client, bufnr)
	end,
})
