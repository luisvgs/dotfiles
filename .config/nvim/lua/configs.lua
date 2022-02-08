local set = vim.opt 
local cmd = vim.cmd

set.undofile = true
set.shiftwidth =4
set.shiftround = true
set.tabstop = 8
set.softtabstop =4
set.smarttab = true
set.cursorline = true
set.expandtab = true
set.clipboard = set.clipboard + "unnamedplus"
set.showcmd = true
set.number = true
set.relativenumber = true
set.hidden = true
set.background = "dark"
set.termguicolors= true
set.mouse = "a"
set.showmode = true
set.completeopt = "menuone","noselect", "noinsert"
set.shortmess = set.shortmess + "c"
set.updatetime = 300

cmd([[
    autocmd FileType javascript set shiftwidth=1|set expandtab| set shiftwidth=2
    autocmd FileType javascriptreact set shiftwidth=1|set expandtab| set shiftwidth=2
]])

-- Rust
vim.g.rust_recommended_style = false
vim.g.rustfmt_autosave = false

-- Haskell
vim.g.haskell_classic_highlighting = false
vim.g.haskell_indent_if = 3
vim.g.haskell_indent_case = 2
vim.g.haskell_indent_let = 4
vim.g.haskell_indent_where = 6
vim.g.hakell_indent_before_where = 2
vim.g.haskell_indent_after_bare_where = 2
vim.g.haskell_indent_do = 3
vim.g.haskell_indent_in = 4
vim.g.haskell_indent_guard = 3
vim.g.haskell_indent_case_alternative = true
vim.g.cabal_indent_section = 2

-- Yank
vim.g.highlightedyank_highlight_duration = 0100


-- Idris
-- vim.g.idris_indent_if = 3
-- vim.g.idris_indent_let = 4
-- vim.g.idris_indent_where = 6
-- vim.g.idris_indent_do = 3
-- vim.g.idris_indent_rewrite = 8
