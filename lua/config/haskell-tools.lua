local ht = require("haskell-tools")

local opts = { noremap = true, silent = true, buffer = bufnr }
ht.setup({
	hls = {
		haskell = {
			formattingProvider = "brittany",
		},
		on_attach = function(client, bufnr)
			vim.keymap.set("n", "<space>ca", vim.lsp.codelens.run, opts)
			vim.keymap.set("n", "<space>hs", ht.hoogle.hoogle_signature, opts)
		end,
	},
})

vim.keymap.set("n", "<leader>rf", function()
	ht.repl.toggle(vim.api.nvim_buf_get_name(0))
end, def_opts)
vim.keymap.set("n", "<leader>rq", ht.repl.quit, def_opts)
