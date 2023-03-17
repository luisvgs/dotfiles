return {
	"matbme/JABS.nvim",
	config = function()
		local map = require("utils").map
		require("jabs").setup({})

		map("n", "<leader>b", "<cmd>JABSOpen<CR>")
	end,
}
