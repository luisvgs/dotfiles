local map = require("utils").map

map("n", "<leader>ft", ":FloatermNew --name=myfloat --height=0.8 --width=0.7 --autoclose=2 zsh<CR> ")
map("n", "t", ":FloatermToggle myfloat<CR>")
map("t", "<C-c>", "<C-\\><C-n>:q<CR>")
