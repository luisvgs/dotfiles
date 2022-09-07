require("plugins")
require("lsp")
require("treesitter-config")
require("keybindings")
require("configs")
require("colorscheme")
require("statusline")
require("fidget").setup({})
require("nvim-navic").setup({})
-- require("focus").setup({ autoresize = true, excluded_buftypes = { "terminal" }, excluded_filetypes = { "toggleterm" } })
require("nvim-autopairs").setup({})
require("fzf-lua").setup({
	winopts = {
		split = "belowright new",
	},
	files = {
		previewer = false,
	},
	grep = {
		previewer = false,
	},
	oldfiles = {
		previewer = false,
	},
})
require("git-conflict").setup({
	default_mappings = true,
	disable_diagnostics = false,
	highlights = {
		incoming = "DiffText",
		current = "DiffAdd",
	},
})
require("lsp-inlayhints").setup()
require("mind").setup()
require("hlargs").setup()
require("hop").setup()
require("colorizer").setup()
