vim.g.tokyonight_italic_comments = 0
vim.g.tokyonight_italic_keywords = 0
vim.g.doom_one_diagnostics_text_color = true
vim.g.doom_one_plugin_lspsaga = true
vim.g.doom_one_plugin_whichkey = true
vim.g.doom_one_cursor_coloring = true
-- vim.cmd([[colorscheme jellybeans-nvim]])
-- vim.cmd([[colorscheme zenburn]])
-- vim.cmd([[colorscheme edge]])
require("tokyonight").setup({
	style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
	transparent = false, -- Enable this to disable setting the background color
	terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
	styles = {
		comments = { italic = false },
		keywords = { italic = false },
		functions = { italic = false },
		variables = { italic = false },
		sidebars = "dark", -- style for sidebars, see below
		floats = "dark", -- style for floating windows
	},
	dim_inactive = false, -- dims inactive windows
	lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
	on_colors = function(colors) end,
	on_highlights = function(highlights, colors) end,
})
-- vim.cmd([[colorscheme tokyonight]])
