require("plugins")
require("lsp")
require("treesitter-config")
require("keybindings")
require("configs")
require("colorscheme")
require("statusline")
require("fidget").setup({})
require("goto-preview").setup({})
require("nvim-navic").setup({})
require("nvim-autopairs").setup({})
require("fzf-lua").setup({
	winopts = {
		split = "belowright new",
	},
	grep = {
		previewer = false,
		cmd = "rg --color=always --smart-case -g '!{.git,node_modules}/'",
	},
	files = {
		previewer = false,
		cmd = "find -type f -not -path '*/node_modules/*' -printf '%P\n'",
	},
	oldfiles = {
		previewer = false,
	},
})
require("git-conflict").setup()
require("hop").setup()
