vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function()
    -- Util
    use 'wbthomason/packer.nvim'
    use { 
	'plasticboy/vim-markdown',
	ft = "markdown"
    }
    use {'qnighy/lalrpop.vim', ft = "lalrpop"}
    use {
	'goolord/alpha-nvim',
	config = function ()
	    require'alpha'.setup(require'alpha.themes.startify'.opts)
	end
    }
    use {
	'nvim-treesitter/nvim-treesitter',
	run = ':TSUpdate', 
    }
    use 'nvim-lua/plenary.nvim'
    use {
	"folke/trouble.nvim",
	requires = "kyazdani42/nvim-web-devicons",
	config = function()
	    require("trouble").setup {}
	end
    }
    use 'godlygeek/tabular'
    use 'justinmk/vim-sneak'

    -- Colorschemes
    use 'rktjmp/lush.nvim'
    use 'navarasu/onedark.nvim'
    use 'ozkanonur/nimda.vim'
    use 'metalelf0/jellybeans-nvim'
    use 'marko-cerovac/material.nvim'
    use 'tjdevries/colorbuddy.vim'
    use 'folke/tokyonight.nvim' 
    use 'NTBBloodbath/doom-one.nvim'

    -- Languages
    use 'rust-lang/rust.vim'

    use {
	'neovimhaskell/haskell-vim',
	ft = "haskell"
    }
    use {
	'alx741/vim-stylishask',
	disable = true,
    }
    use {
	'itchyny/vim-haskell-indent',
	ft = "haskell"
    }
    use({'scalameta/nvim-metals', ft = "scala" -- Scala
    })
    use {
	"ckipp01/scala-utils.nvim", ft = "scala"
    }

    -- Workflow
    use 'tpope/vim-surround'
    use { "junegunn/fzf", run = "./install --all" }
    use { "junegunn/fzf.vim" }
    use { 
	"tversteeg/registers.nvim",
	disable = true,
    }
    use 'tpope/vim-commentary'
    use 'tjdevries/express_line.nvim'
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use {
	'nvim-telescope/telescope.nvim',
	disable = true,
	config = function()
	    vim.cmd[[ nnoremap <leader>ta <cmd>Telescope lsp_document_symbols theme=get_ivy<cr> ]]
	    vim.cmd[[ nnoremap <leader>bb <cmd>Telescope buffers<cr> ]]
	    vim.cmd[[ nnoremap <leader>fg <cmd>Telescope live_grep<cr> ]]
	    vim.cmd[[ 
	    nnoremap <leader>fo :lua require'telescope.builtin'
	    .oldfiles(require('telescope.themes')
	    .get_ivy({ 
		prompt_title=false,winblend = 2, 
		previewer=false,
		layout_config = { height = 11 } 
	    }))<cr> 
	    ]]
	    vim.cmd[[ nnoremap <leader>fb :lua require'telescope.builtin'
	    .file_browser(require('telescope.themes')
	    .get_dropdown({ 
		winblend = 2, 
		previewer= false 
	    }))<cr> 
	    ]]
	    vim.cmd[[ nnoremap <leader>ff :lua require'telescope.builtin'
	    .find_files(require('telescope.themes')
	    .get_ivy({ 
		winblend = 2, 
		previewer=false 
	    }))<cr> 
	    ]]
	end
    }
    use 'machakann/vim-highlightedyank'
    use 'jiangmiao/auto-pairs'
    use 'camspiers/lens.vim'
    use {
	'gabrielpoca/replacer.nvim',
    }
    use 'kyazdani42/nvim-web-devicons' 

    -- LSP
    use 'onsails/lspkind-nvim'
    use 'neovim/nvim-lspconfig'
    use 'jose-elias-alvarez/null-ls.nvim'
    use 'jose-elias-alvarez/nvim-lsp-ts-utils'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use {
	'nvim-lua/lsp_extensions.nvim',
	as = 'lsp_extensions',
	config = function()
	    vim.cmd [[
	    au BufEnter,BufWinEnter,BufWritePost,InsertLeave,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{ prefix = " » " }
	    ]]
	end
    }
    use 'nvim-lua/lsp-status.nvim'
end)
