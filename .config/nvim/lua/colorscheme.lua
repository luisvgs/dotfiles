vim.g.nimda_use_gui_italics= 0
vim.g.tokyonight_italic_comments = 0
vim.g.tokyonight_italic_keywords = 0
vim.g.tokyonight_style = "night"
-- vim.cmd[[colorscheme jellybeans-nvim]]
-- vim.cmd[[colorscheme doom-one]]
-- vim.cmd[[colorscheme tokyonight]]
-- vim.cmd[[colorscheme nimda]]

require('kanagawa').setup({
    undercurl = true,           -- enable undercurls
    commentStyle = "NONE",
    functionStyle = "NONE",
    keywordStyle = "NONE",
    statementStyle = "NONE",
    typeStyle = "NONE",
    variablebuiltinStyle = "NONE",
    specialReturn = true,       -- special highlight for the return keyword
    specialException = true,    -- special highlight for exception handling keywords 
    transparent = false,        -- do not set background color
    colors = {},
    overrides = {},
})
vim.cmd("colorscheme kanagawa")

