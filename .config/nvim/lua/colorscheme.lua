vim.g.nimda_use_gui_italics= 0
vim.g.tokyonight_italic_comments = 0
vim.g.tokyonight_italic_keywords = 0
vim.g.tokyonight_style = "night"
vim.g.neon_style = "doom"

vim.cmd[[colorscheme jellybeans-nvim]]
-- vim.cmd[[colorscheme doom-one]]
-- vim.cmd[[colorscheme neon]]
-- vim.cmd[[colorscheme tokyonight]]
require('onedark').setup {
    style = 'warmer'
}
-- require('onedark').load()
