source ~/.config/nvim/keybindings.vim

lua require('plugins')
lua require('lsp')
lua require('treesitter-config')
lua require('keybindings')
lua require('configs')
lua require('colorscheme')
lua require('el').setup{}
lua require('focus').setup{}
