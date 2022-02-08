require('plugins')
require('lsp')
require('treesitter-config')
require('keybindings')
require('configs')
require('colorscheme')
require('el').setup{}
require('focus').setup({autoresize = true, excluded_buftypes = {"terminal"}, excluded_filetypes = {"toggleterm"} })
