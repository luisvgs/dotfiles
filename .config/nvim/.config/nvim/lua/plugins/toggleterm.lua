return {
	"akinsho/toggleterm.nvim",
	config = function()
		require("toggleterm").setup({
			open_mapping = [[<C-\>]],
			shade_terminals = false,
			direction = "horizontal",
			size = function(term)
				if term.direction == "horizontal" then
					return 10
				elseif term.direction == "vertical" then
					return 13
				end
			end,
		})
	end,
}
