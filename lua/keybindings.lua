local map = require("utils").map
vim.g.mapleader = " "

-- Leap

-- Tagbar
map("n", "<leader>tt", "<cmd>SymbolsOutlineOpen<cr>")
map("n", "<leader>tc", "<cmd>SymbolsOutlineClose<<cr>")

-- Inlay Hints
map("n", "<leader>ti", ":lua require('lsp-inlayhints').toggle()<cr>")

-- Git-conflict
map("n", "<leader>gq", "<cmd>GitConflictListQf<cr>")

-- Fugitive
map("n", "<leader>gg", "<cmd>G<cr>")
map("n", "<leader>gc", "<cmd>Git commit<cr>")
map("n", "<leader>gd", "<cmd>Git diff<cr>")
map("n", "<leader>gl", "<cmd>Git log<cr>")

-- Replacer
map("n", "<leader>h", ':lua require("replacer").run()<cr>')

-- Source current buffer
map("n", "<leader>s", ":source %<cr>")

-- Window resizing alternative using arrow keys
map("n", "<Left>", ":vertical +2<cr>")
map("n", "<Right>", ":vertical -2<cr>")
map("n", "<Up>", ":resize -2<cr>")
map("n", "<Down>", ":resize +2<cr>")

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
map("n", ",v", "<C-w>v")
map("n", ",h", "<C-w>s")

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

-- Sends any deleted text to the black hole register
-- map("n", "x", '"_x')
-- map("n", "d", '"_d')
-- map("n", "D", '"_D')
-- map("v", "d", '"_d')
-- map("n", "<leader>d", '""d')
-- map("n", "<leader>D", '""D')
-- map("v", "<leader>d", '""d')

-- Wraps word in cursor in ()
-- map("n", "<leader>z", "viw<esc>a)<esc>hbi(<esc>lel")
-- map("n", "<leader>cb", "viw<esc>a}<esc>hbi{<esc>lel")

-- " Keep star command in the same position
-- nnoremap * m`:keepjumps normal! *``<cr>
map("n", "*", "m`:keepjumps normal! *``<cr>")

-- Stop text search highlight
map("n", "<esc>", ":noh<cr>")

-- map ctrl+s to :w
map("n", "<c-s>", ":w<cr>")
map("i", "<c-s>", "<Esc>:w<cr>a")

-- Movement: maps c-e to $ such as inoremap <C-e> <C-o>$
map("i", "<c-e>", "<c-o>$")

-- Packer
map("n", "<leader>pi", "<cmd>PackerInstall<cr>")
map("n", "<leader>pu", "<cmd>PackerUpdate<cr>")
map("n", "<leader>pc", "<cmd>PackerClean<cr>")
map("n", "<leader>pr", "<cmd>PackerCompile<cr>")

-- Quick access to common files.
map("n", "<leader>oci", "<cmd>edit ~/.config/nvim/init.lua<cr>")
map("n", "<leader>ock", "<cmd>edit ~/.config/nvim/lua/keybindings.lua<cr>")
map("n", "<leader>ocl", "<cmd>edit ~/.config/nvim/lua/lsp.lua<cr>")
map("n", "<leader>ocp", "<cmd>edit ~/.config/nvim/lua/plugins.lua<cr>")
map("n", "<leader>occ", "<cmd>edit ~/.config/nvim/lua/configs.lua<cr>")

-- Automatically jump to end of text you pasted
map("v", "y", "y`]")
map("v", "p", "p`]")
map("n", "p", "p`]")

map("x", "<leader>p", '"_dP')
