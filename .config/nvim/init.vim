source ~/.config/nvim/common.vim
lua require('plugins')
source ~/.config/nvim/keybindings.vim
lua require('lsp')
lua require('colorscheme')
lua require('treesitter-config')
lua require('el').setup{}
