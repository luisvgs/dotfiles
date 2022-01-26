source ~/.config/nvim/common.vim
source ~/.config/nvim/keybindings.vim
lua require('plugins')
lua require('lsp')
lua require('treesitter-config')
lua require('el').setup{}
lua require('focus').setup{}
lua require('colorscheme')
