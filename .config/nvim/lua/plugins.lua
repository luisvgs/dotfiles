vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function()
    -- Util
    use 'wbthomason/packer.nvim'
    use { 
	'plasticboy/vim-markdown',
	ft = "markdown"
    }
    use {'qnighy/lalrpop.vim', ft = "lalrpop"}
    use 'windwp/nvim-ts-autotag'
    use 'tpope/vim-fugitive'
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
    use 'rlane/pounce.nvim'

    -- Colorschemes
    use 'rktjmp/lush.nvim'
    use 'navarasu/onedark.nvim'
    use 'ozkanonur/nimda.vim'
    use 'metalelf0/jellybeans-nvim'
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
    use 'tpope/vim-commentary'
    use 'tjdevries/express_line.nvim'
    use 'machakann/vim-highlightedyank'
    use 'jiangmiao/auto-pairs'
    use 'beauwilliams/focus.nvim'
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
	disable = true,
	as = 'lsp_extensions',
	config = function()
	    vim.cmd [[
	    au BufEnter,BufWinEnter,BufWritePost,InsertLeave,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{ prefix = " » " }
	    ]]
	end
    }
    use 'nvim-lua/lsp-status.nvim'
end)
