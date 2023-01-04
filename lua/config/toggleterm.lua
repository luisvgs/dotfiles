local map = require("utils").map
require("toggleterm").setup({
	shade_terminals = false,
})

map("n", "<leader>ot", "<cmd>ToggleTerm size=10 direction=horizontal<cr>")
