require("catppuccin").setup({
	flavour = "mocha", -- latte, frappe, macchiato, mocha
	term_colors = true,
	dim_inactive = {
		enabled = true,
		shade = "dark",
		percentage = 0.15,
	},
	transparent_background = false,
	no_italic = true,
	no_bold = false,
	styles = {
		comments = {},
		conditionals = {},
		loops = {},
		functions = {},
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
	},
	color_overrides = {
		mocha = {
			base = "#000000",
			mantle = "#000000",
			crust = "#211924",
		},
	},
	highlight_overrides = {
		mocha = function(C)
			return {
				TabLineSel = { bg = C.pink },
				CmpBorder = { fg = C.surface2 },
				Pmenu = { bg = C.none },
				TelescopeBorder = { link = "FloatBorder" },
			}
		end,
	},
})

vim.cmd.colorscheme("catppuccin")
