local map = require("utils").map
local fzf = require("fzf-lua")

map("n", "<C-F>", "<cmd>lua require('fzf-lua').files()<CR>")
map("n", "<C-P>", "<cmd>lua require('fzf-lua').oldfiles()<CR>")
map("n", "<leader>fc", "<cmd>lua require('fzf-lua').git_commits()<CR>")
map("n", "<leader>gs", "<cmd>lua require('fzf-lua').git_status()<CR>")
map("n", "<leader>rg", "<cmd>lua require('fzf-lua').grep_project()<CR>")
map("n", "<leader>rp", "<cmd>lua require('fzf-lua').grep()<CR>")

fzf.setup({
	winopts = {
		split = "belowright new | resize -10",
	},
	files = {
		previewer = false,
		cmd = "fd --type f --exclude '!{.git,node_modules,target}/'",
	},
	grep = {
		previewer = false,
		cmd = "rg --color=always --smart-case -g '!{.git,node_modules}/'",
	},
	oldfiles = {
		previewer = false,
	},
})
