local set = vim.opt
local cmd = vim.cmd

set.undofile = true
set.shiftwidth = 4
set.shiftround = true
set.tabstop = 8
set.softtabstop = 4
set.smarttab = true
set.cursorline = true
set.expandtab = true
-- set.clipboard = set.clipboard + "unnamedplus"
set.showcmd = true
set.number = true
set.relativenumber = true
set.hidden = true
set.background = "dark"
set.termguicolors = true
set.mouse = "a"
set.showmode = true
set.completeopt = "menuone", "noselect", "noinsert"
set.shortmess = set.shortmess + "c"
set.updatetime = 300
set.fillchars = set.fillchars + "diff:╱"
set.laststatus = 3

cmd([[
    autocmd FileType javascriptreact setlocal commentstring={/*\ %s\ */}
    autocmd FileType javascript set shiftwidth=1|set expandtab| set shiftwidth=2
    autocmd FileType javascriptreact set shiftwidth=1|set expandtab| set shiftwidth=2
    autocmd FileType make setlocal noexpandtab
    autocmd FileType haskell setlocal expandtab
    autocmd FileType haskell let b:autoformat_autoindent = 0
]])

vim.api.nvim_set_option("clipboard", "unnamed")

function _G.set_terminal_keymaps()
	local opts = { noremap = true }
	vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")

-- Rust
vim.g.rust_recommended_style = true
vim.g.rustfmt_autosave = false

-- FZF
vim.g.fzf_preview_window = {}
vim.g.fzf_layout = { down = "35%" }
vim.g.fzf_action = {
	["ctrl-t"] = "tab split",
	["ctrl-i"] = "split",
	["ctrl-v"] = "vsplit",
}
vim.g.fzf_colors = {
	["fg"] = { "fg", "Normal" },
	["bg"] = { "bg", "Normal" },
	["hl"] = { "fg", "Comment" },
	["fg+"] = { "fg", "CursorLine", "CursorColumn", "Normal" },
	["bg+"] = { "bg", "CursorLine", "CursorColumn" },
	["hl+"] = { "fg", "Statement" },
	["info"] = { "fg", "PreProc" },
	["border"] = { "fg", "Ignore" },
	["prompt"] = { "fg", "Conditional" },
	["pointer"] = { "fg", "Exception" },
	["marker"] = { "fg", "Keyword" },
	["spinner"] = { "fg", "Label" },
	["header"] = { "fg", "Comment" },
}

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

-- Markdown stuff
vim.g.vim_markdown_folding_disabled = true

-- Idris
-- vim.g.idris_indent_if = 3
-- vim.g.idris_indent_let = 4
-- vim.g.idris_indent_where = 6
-- vim.g.idris_indent_do = 3
-- vim.g.idris_indent_rewrite = 8
