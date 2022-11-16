require("plugins")
require("lsp")
require("treesitter-config")
require("keybindings")
require("configs")
require("colorscheme")
require("statusline")
require("fidget").setup({})
require("nvim-navic").setup({})
require("nvim-autopairs").setup({})
require("lsp-inlayhints").setup()
require("hlargs").setup()
require("colorizer").setup()
require("hl-workaround")
require("dirbuf").setup({})
require("notify").setup({
	stages = "static",
	timeout = 3000,
	render = "minimal",
})

-- require("status_custom")
