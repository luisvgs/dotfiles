return {
    "akinsho/toggleterm.nvim",
    config = function()
        local term = require("toggleterm")
        term.setup({
            open_mapping = [[<C-\>]],
            shade_terminals = true,
            start_in_insert = false,
            close_on_exit = true,
            hide_numbers = true,
            direction = "horizontal",
            size = function(term)
                if term.direction == "horizontal" then
                    return 10
                elseif term.direction == "vertical" then
                    return 13
                end
            end,
        })
        local map = require("utils").map

        map("n", "<leader>dx", "<cmd>TermExec cmd=dcr direction=vertical size=50<CR>")
        map("n", "<leader>db", "<cmd>TermExec cmd=db<CR>")
        map("n", "<leader>ct", "<cmd>TermExec cmd='cargo t' go_back=0 size=15<CR>")
        map("n", "<leader>cr", "<cmd>TermExec cmd='cargo run' go_back=0 size=15<CR>")
        map("n", "<leader>cc", "<cmd>TermExec cmd='cargo c' go_back=0 size=15<CR>")
    end,
}
