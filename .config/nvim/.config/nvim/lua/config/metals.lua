local metals_config = require("metals").bare_config()
metals_config.settings = {
	showImplicitArguments = false,
	showInferredType = true,
	excludedPackages = {},
}

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

metals_config.on_attach = lsp_attach
metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
metals_config.init_options.statusBarProvider = "on"
metals_config.root_patterns = { ".git" }

-- Autocmd that will actually be in charging of starting the whole thing
local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "scala", "sbt", "java" },
	callback = function(opts)
		require("metals").initialize_or_attach(metals_config)

		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = opts.buf,
			callback = function()
				vim.lsp.buf.format({ timeout_ms = 3000 })
			end,
		})
	end,
	group = nvim_metals_group,
})
-- metals_config.init_options.statusBarProvider = "on"
-- require("metals").initialize_or_attach(metals_config)
