local map = require("utils").map
vim.g.mapleader = " "

-- Fugitive
map("n", "<leader>gs", "<cmd>G<cr>")
map("n", "<leader>gc", "<cmd>Git commit<cr>")
map("n", "<leader>gd", "<cmd>Git diff<cr>")
map("n", "<leader>gl", "<cmd>Git log<cr>")

-- Focus
map("n", "<leader>l", "<cmd>FocusSplitRight<cr>")
map("n", "<leader>j", "<cmd>FocusSplitDown<cr>")
map("n", "<leader>k", "<cmd>FocusSplitUp<cr>")

-- Pounce
map("n", "<leader>p", "<cmd>Pounce<cr>")

-- Tabularize (for Haskell, mostly)
map("n", "<leader>=", "<cmd>Tabularize /=<cr>")
map("n", "<leader>-", "<cmd>Tabularize /-<cr>")
map("n", "<leader>,", "<cmd>Tabularize /,<cr>")
map("n", "<leader>#", "<cmd>Tabularize /#-}<cr>")

-- Trouble
map("n", "<leader>xx", "<cmd>TroubleToggle<cr>")

-- Source current buffer
map("n", "<leader>s", ":source %<cr>")

-- Window resizing alternative using arrow keys
map("n", "<Left>", ":vertical +2<cr>")
map("n", "<Right>", ":vertical -2<cr>")
map("n", "<Up>", ":resize -2<cr>")
map("n", "<Down>", ":resize +2<cr>")

-- Clippy
map("n", "<C-Y>", ":RustFmt<cr>")

-- FZF Keybindings
map("n", "<C-F>", ":Files %:p:h<cr>")
map("n", "<C-B>", ":Buffers <cr>")
map("n", "<C-P>", ":History<cr>")

-- Buffer navigation
map("n", "<leader>q", ":bd!<cr>")
map("n", "<leader><leader>", "<c-^>")
map("n", "<C-w>", ":bprevious<cr>")
map("n", "<C-e>", ":bnext<cr>")
map("n", "<C-q>", ":q<cr>")

-- Copy and paste
map("n", "p", "gp")
map("n", "P", "gP")
map("n", "gp", "p")
map("n", "gP", "P")
map("n", "<leader>y", '"+y')
map("n", "<leader>p", '"+p')

-- Creates vertical and horizontal plits
map("n", ",v", '<C-w>v')
map("n", ",h", '<C-w>s')

-- Move with hjkl to active split
map("n", "<C-k>", ":wincmd k<cr>")
map("n", "<C-j>", ":wincmd j<cr>")
map("n", "<C-h>", ":wincmd h<cr>")
map("n", "<C-l>", ":wincmd l<cr>")

-- Move blocks of code in visual mode
map("x", "K", ":move '<-2<cr>gv-gv")
map("x", "J", ":move '>+1<cr>gv-gv")

-- Identation with < and >
map("v", "<", "<gv")
map("v", ">", ">gv")
