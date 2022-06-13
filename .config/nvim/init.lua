require("plugins")
require("lsp")
require("treesitter-config")
require("keybindings")
require("configs")
require("colorscheme")
require("statusline")
-- require('express')
require("fidget").setup({})
require("nvim-navic").setup({})
require("toggleterm").setup({ shade_terminals = false, persist_size = false })
require("focus").setup({ autoresize = true, excluded_buftypes = { "terminal" }, excluded_filetypes = { "toggleterm" } })
require("nvim-autopairs").setup({})
require("fzf-lua").setup({
	files = {
		previewer = false,
	},
	oldfiles = {
		previewer = false,
	},
})
