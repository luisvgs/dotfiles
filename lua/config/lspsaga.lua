local keymap = vim.keymap.set
local saga = require("lspsaga")

saga.init_lsp_saga({
	code_action_lightbulb = {
		enable = false,
	},
	border_style = "single",
})

local opts = { noremap = true, silent = true }
keymap("n", "<C-g>", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)
keymap("n", "K", "<Cmd>Lspsaga hover_doc<CR>", opts)
keymap("n", "gd", "<Cmd>Lspsaga lsp_finder<CR>", opts)
keymap("n", "gk", "<Cmd>Lspsaga signature_help<CR>", opts)
keymap("n", "gp", "<Cmd>Lspsaga peek_definition<CR>", opts)
keymap("n", "gr", "<Cmd>Lspsaga rename<CR>", opts)
