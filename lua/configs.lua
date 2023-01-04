local set = vim.opt
local cmd = vim.cmd

set.undofile = true
set.shiftwidth = 4
set.shiftround = true
set.numberwidth = 1
set.tabstop = 8
set.softtabstop = 4
set.smarttab = true
set.cursorline = true
set.expandtab = true
-- set.clipboard = set.clipboard + "unnamedplus"
set.showcmd = true
set.number = false
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
vim.o.timeoutlen = 500

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

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	callback = function()
		vim.api.nvim_command([[%s/\s\+$//e]])
	end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	pattern = { "*" },
	callback = function()
		vim.highlight.on_yank()
	end,
})

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
