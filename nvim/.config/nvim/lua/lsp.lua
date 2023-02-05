local lsp = require("lspconfig")
local lsp_status = require("lsp-status")
local null_ls = require("null-ls")
local navic = require("nvim-navic")
local lsp_attach = require("functions").lsp_attach
-- vim.notify = require("notify")

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

vim.cmd([[
  hi StatusLineLinNbr guibg=#23272e guifg=#51afef
  hi StatusLineLSPOk guibg=#23272e guifg=#98be65
  hi StatusLineLSPErrors guibg=#23272e guifg=#ff6c6b
  hi StatusLineLSPWarnings guibg=#23272e guifg=#ECBE7B
  hi StatusLineLSPInfo guibg=#23272e guifg=#51afef
  hi StatusLineLSPHints guibg=#23272e guifg=#c678dd
]])

vim.diagnostic.config({
	virtual_text = {
		prefix = "",
		spacing = 6,
	},
	float = {
		header = false,
		source = "always",
	},
	signs = true,
	underline = false,
	update_in_insert = false,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
vim.tbl_extend("keep", capabilities, lsp_status.capabilities)

-- Haskell.
lsp.hls.setup({
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		navic.attach(client, bufnr)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>hi", "<cmd>belowright 7sp | term ghci %<cr>", {})
		return lsp_attach(client, bufnr)
	end,
	settings = {
		haskell = { formattingProvider = "brittany", "--indent=4" },
	},
})

-- Bash
lsp.bashls.setup({
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		navic.attach(client, bufnr)
		return lsp_attach(client, bufnr)
	end,
})

-- Lua
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
		client.server_capabilities.document_formatting = false
		client.server_capabilities.document_range_formatting = false
		return lsp_attach(client, bufnr)
	end,
})

-- Rust
lsp.rust_analyzer.setup({
	capabilities = capabilities,
	cmd = { "rust-analyzer" },
	settings = {
		["rust-analyzer"] = {
			assist = {
				importGranularity = "module",
				importPrefix = "by_self",
			},
			checkOnSave = {
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
				enableExperimental = true,
			},
			inlayHints = {
				chainingHints = true,
				parameterHints = true,
				typeHints = true,
			},
			procMacro = {
				enable = true,
			},
		},
	},

	flags = {
		debounce_text_changes = 150,
	},

	on_attach = function(client, bufnr)
		-- navic.attach(client, bufnr)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cb", "<cmd>belowright 15sp | term cargo build<cr>", {})
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cc", "<cmd>belowright 15sp | term cargo clippy<cr>", {})
		vim.api.nvim_buf_set_keymap(
			bufnr,
			"n",
			"<localleader>br",
			"<cmd>belowright 10sp | term cargo build --release<cr>",
			{}
		)
		vim.api.nvim_buf_set_keymap(
			bufnr,
			"n",
			"<localleader>db",
			"<cmd>belowright 10sp | term rustup doc --book<cr>",
			{}
		)
		vim.api.nvim_buf_set_keymap(
			bufnr,
			"n",
			"<localleader>dd",
			"<cmd>belowright 10sp | term cargo doc --open<cr>",
			{}
		)
		vim.api.nvim_buf_set_keymap(
			bufnr,
			"n",
			"<localleader>ds",
			"<cmd>belowright 10sp | term rustup doc --std<cr>",
			{}
		)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cr", "<cmd>belowright 15sp | term cargo run<cr>", {})
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ct", "<cmd>belowright 15sp | term cargo t<cr>", {})

		-- local msg = string.format("Language server %s started.", client.name)
		-- vim.notify(msg, "info")

		return lsp_attach(client, bufnr)
	end,
})
