local lsp = require("lspconfig")
local lsp_status = require("lsp-status")
local null_ls = require("null-ls")
local navic = require("nvim-navic")

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

local lsp_attach = function()
	return function(client, bufnr)
		if client.server_capabilities.document_formatting then
			vim.cmd([[
                          augroup LspFormatting
                          autocmd! * <buffer>
                          autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
                          augroup END
                        ]])
		end

		lsp_status.on_attach(client)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", {})
		vim.api.nvim_buf_set_keymap(
			bufnr,
			"n",
			"<leader>clr",
			"<cmd>lua vim.lsp.stop_client(vim.lsp.get_active_clients())<cr>",
			{}
		)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cd", "<cmd>lua vim.lsp.buf.type_definition()<cr", {})
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-h>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", {})
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>K", "<cmd>lua vim.lsp.buf.hover()<cr>", {})
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", {})
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<cr>", {})
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-K>", "<cmd>lua vim.diagnostic.goto_next()<cr>", {})
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-J>", "<cmd>lua vim.diagnostic.goto_prev()<cr>", {})
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>aa", "<cmd>lua vim.buf.code_action()<cr>", {})
		vim.api.nvim_buf_set_keymap(
			bufnr,
			"n",
			"<leader>ca",
			"<cmd>Telescope lsp_code_actions theme=get_dropdown<cr>",
			{}
		)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gr", "<cmd>Telescope lsp_references<cr>", {})
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cs", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", {})
		vim.api.nvim_buf_set_keymap(
			bufnr,
			"n",
			"<leader>td",
			"<cmd>Telescope diagnostics border=false layout_config={height=0.3}<cr>",
			{}
		)
		vim.api.nvim_buf_set_keymap(
			bufnr,
			"x",
			"<leader>ca",
			"<cmd>Telescope lsp_range_code_actions theme=get_dropdown<cr>",
			{}
		)
	end
end

-- Setup nvim-cmp.
local cmp = require("cmp")
local kind = require("lspkind")
cmp.setup({
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
	},
	snippet = {
		expand = function(args)
			require("snippy").expand_snippet(args.body)
		end,
	},
	formatting = {
		format = kind.cmp_format({ with_text = true, maxwidth = 50 }),
	},
	sources = cmp.config.sources(
		{ { name = "nvim_lsp" } },
		{ { name = "buffer" } },
		{ { name = "snippy" } },
		{ { name = "path" } }
	),
})

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
vim.tbl_extend("keep", capabilities, lsp_status.capabilities)

-- Bash
lsp.bashls.setup({
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		navic.attach(client, bufnr)
		return lsp_attach()(client, bufnr)
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
		return lsp_attach()(client, bufnr)
	end,
})

-- Typescript
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.stylua,
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
			local msg = string.format("Language server %s started!", client.name)
			vim.notify(msg)
		end
	end,
})

local buf_map = function(bufnr, mode, lhs, rhs, opts)
	vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
		silent = true,
	})
end

require("typescript").setup({
	disable_commands = false,
	debug = false,
	go_to_source_definition = {
		fallback = true,
	},
	server = {
		on_attach = function(client, bufnr)
			client.server_capabilities.document_formatting = false
			client.server_capabilities.document_range_formatting = false

			local ts_utils = require("nvim-lsp-ts-utils")
			ts_utils.setup({ import_all_timeout = 5000, enable_formatting = false })
			ts_utils.setup_client(client)
			return lsp_attach()(client, bufnr)
		end,
	},
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
			rustfmt = {
				enableRangeFormatting = true,
			},

			diagnostics = {
				enable = true,
				enableExperimental = true,
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
		debounce_text_changes = 150,
	},

	on_attach = function(client, bufnr)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cb", "<cmd>belowright 17sp | term cargo build<cr>", {})
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cc", "<cmd>belowright 17sp | term cargo clippy<cr>", {})
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
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cr", "<cmd>belowright 17sp | term cargo run<cr>", {})
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ct", "<cmd>belowright 17sp | term cargo t<cr>", {})
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ctq", "<cmd>belowright 17sp | term cargo t -q<cr>", {})
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cm", "<cmd>belowright 17sp | term cargo t ::<cr>", {})
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cmq", "<cmd>belowright 17sp | term cargo t -q ::<cr>", {})

		require("lsp-inlayhints").on_attach(client, bufnr)
		navic.attach(client, bufnr)

		local msg = string.format("Language server %s started.", client.name)
		vim.notify(msg)

		return lsp_attach()(client, bufnr)
	end,
})
