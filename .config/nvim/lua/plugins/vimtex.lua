return {
    "lervag/vimtex",
    config = function()
        local map = require("utils").map

        vim.g.vimtex_view_general_viewer = 'zathura'
        vim.g.vimtex_view_method = 'zathura'


        map("n", "<leader>ll", "<cmd>VimtexCompile<CR>")
        map("n", "<leader>lls", "<cmd>VimtexCompileSS<CR>")
        map("n", "<leader>llx", "<cmd>VimtexStop<CR>")
        map("n", "<leader>llv", "<cmd>VimtexView<CR>")
    end,
}
