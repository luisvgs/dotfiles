local lsp = require("lspconfig")
local lsp_status = require("lsp-status")
local navic = require("nvim-navic")
local lsp_attach = require("functions").lsp_attach

lsp_status.register_progress()
lsp_status.config({
	current_function = false,
	status_symbol = "%#StatusLineLinNbr#LSP",
	indicator_errors = "%#StatusLineLSPErrors#",
	indicator_warnings = "%#StatusLineLSPWarnings#",
	indicator_info = "%#StatusLineLSPInfo#",
	indicator_hints = "%#StatusLineLSPHints#",
	indicator_ok = "%#StatusLineLSPOk#",
})

local signs = {
	{ name = "DiagnosticSignError", text = "█" },
	{ name = "DiagnosticSignWarn", text = "█" },
	{ name = "DiagnosticSignHint", text = "█" },
	{ name = "DiagnosticSignInfo", text = "█" },
}

for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

vim.diagnostic.config({
	virtual_text = {
		prefix = "",
		spacing = 6,
		format = function(diagnostic)
			return string.format("[%s]\n%s", diagnostic.source, diagnostic.message)
		end,
	},
	float = {
		header = false,
		source = "always",
		style = "minimal",
		border = "rounded",
		prefix = "",
	},
	signs = false,
	underline = false,
	update_in_insert = false,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
vim.tbl_extend("keep", capabilities, lsp_status.capabilities)

lsp.bashls.setup({
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		navic.attach(client, bufnr)
		return lsp_attach(client, bufnr)
	end,
})

lsp.sumneko_lua.setup({
	cmd = { "/usr/bin/lua-language-server" },
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = {
				enable = true,
				globals = {
					"vim",
				},
			},
			format = {
				enable = false,
			},
		},
	},
	on_attach = function(client, bufnr)
		navic.attach(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
		return lsp_attach(client, bufnr)
	end,
})

lsp.rust_analyzer.setup({
	capabilities = capabilities,
	cmd = { "rust-analyzer" },
	settings = {
		["rust-analyzer"] = {
			checkOnSave = {
				command = "clippy",
				enable = false,
				allFeatures = false,
			},

			completion = {
				addCallArgumentSnippets = true,
				addCallParenthesis = true,
				postfix = {
					enable = true,
				},
				autoimport = {
					enable = false,
				},
			},

			diagnostics = {
				enable = true,
				enableExperimental = false,
			},

			inlayHints = {
				chainingHints = false,
				parameterHints = true,
				typeHints = true,
			},

			procMacro = {
				enable = true,
			},
		},
	},

	flags = {
		debounce_text_changes = 350,
	},

	on_attach = function(client, bufnr)
		require("lsp-inlayhints").on_attach(client, bufnr)
		navic.attach(client, bufnr)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cb", "<cmd>belowright 10sp | term cargo build<cr>", {})
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cc", "<cmd>belowright 15sp | term cargo clippy<cr>", {})
		vim.api.nvim_buf_set_keymap(
			bufnr,
			"n",
			"<localleader>br",
			"<cmd>belowright 10sp | term cargo build --release<cr>",
			{}
		)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cr", "<cmd>belowright 15sp | term cargo run<cr>", {})
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ct", "<cmd>belowright 15sp | term cargo t<cr>", {})

		return lsp_attach(client, bufnr)
	end,
})
