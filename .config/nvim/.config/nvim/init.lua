require("plugins")
require("lsp")
require("treesitter-config")
require("keybindings")
require("configs")
require("statusline")
require("fidget").setup({ text = { spinner = "moon" } })
require("nvim-autopairs").setup({})
require("lsp-inlayhints").setup()
require("colorizer").setup()
require("dirbuf").setup({})
