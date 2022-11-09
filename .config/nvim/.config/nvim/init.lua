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
-- require("fzf-lua").setup({
-- 	winopts = {
-- 		split = "belowright new",
-- 	},
-- 	files = {
-- 		previewer = false,
-- 		cmd = "find -type f -not -path '*/node_modules/*' -not -path '*/target/*' -printf '%P\n'",
-- 	},
-- 	grep = {
-- 		previewer = false,
-- 		cmd = "rg --color=always --smart-case -g '!{.git,node_modules}/'",
-- 	},
-- 	oldfiles = {
-- 		previewer = false,
-- 	},
-- })
require("git-conflict").setup({
	default_mappings = true,
	disable_diagnostics = false,
	highlights = {
		incoming = "DiffText",
		current = "DiffAdd",
	},
})
require("lsp-inlayhints").setup()
require("hlargs").setup()
require("colorizer").setup()
require("lspsaga").init_lsp_saga({
	code_action_lightbulb = {
		enable = false,
	},
})
require("hl-workaround")
require("dirbuf").setup({})
require("notify").setup({
	stages = "static",
	timeout = 3000,
	render = "minimal",
})
require("goto-preview").setup({ default_mappings = true })
require("git-worktree").setup()
require("telescope").setup({
	defaults = {
		sorting_strategy = "ascending",
		border = false,
		mappings = {
			i = {
				["<C-j>"] = require("telescope.actions").move_selection_next,
				["<C-k>"] = require("telescope.actions").move_selection_previous,
			},
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
})
require("telescope").load_extension("git_worktree")
require("telescope").load_extension("fzf")
local TelescopePrompt = {
	TelescopePromptNormal = {
		bg = "#2d3149",
	},
	TelescopePromptBorder = {
		bg = "#2d3149",
	},
	TelescopePromptTitle = {
		fg = "#2d3149",
		bg = "#2d3149",
	},
	TelescopePreviewTitle = {
		fg = "#1F2335",
		bg = "#1F2335",
	},
	TelescopeResultsTitle = {
		fg = "#1F2335",
		bg = "#1F2335",
	},
}
for hl, col in pairs(TelescopePrompt) do
	vim.api.nvim_set_hl(0, hl, col)
end
