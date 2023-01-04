local trouble = require("trouble")
local map = require("utils").map

map("n", "<leader>xx", "<cmd>TroubleToggle<cr>")

trouble.setup({})
