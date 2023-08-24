return {
    "dcampos/nvim-snippy",
    config = function()
        local snippy = require("snippy")

        snippy.setup({
            mappings = {
                is = {
                    ["<Tab>"] = "expand_or_advance",
                    ["<S-Tab>"] = "previous",
                },
                nx = {
                    ["<leader>x"] = "cut_text",
                },
            },
        })

        vim.keymap.set("i", "<C-s>", function()
            require("snippy").complete()
        end, { silent = true })
    end,
}
