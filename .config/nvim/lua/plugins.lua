vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    -- Util
    use { 'plasticboy/vim-markdown' }

    use {
        'phaazon/hop.nvim',
	disable = true,
        branch = 'v1', -- optional but strongly recommended
        config = function()
	    require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
        end
    }

    use 'lewis6991/impatient.nvim'

    use {'google/vim-maktaba'}

    use 'qnighy/lalrpop.vim'

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

    use 'glepnir/dashboard-nvim'

    use 'kevinhwang91/nvim-bqf'

    use 'godlygeek/tabular'

    use 'dstein64/vim-startuptime'

    use 'justinmk/vim-sneak'

    -- Colorschemes
    use 'rktjmp/lush.nvim'

    use "rebelot/kanagawa.nvim"

    use 'ozkanonur/nimda.vim'

    use 'metalelf0/jellybeans-nvim'

    -- use 'marko-cerovac/material.nvim'
    
    use 'tjdevries/colorbuddy.vim'

    use 'folke/tokyonight.nvim' 

    use 'NTBBloodbath/doom-one.nvim'

    -- Languages
    use 'rust-lang/rust.vim'

    use 'neovimhaskell/haskell-vim' -- Haskell stuff
    use {
	'alx741/vim-stylishask',
	disable = true,
    }
    use 'itchyny/vim-haskell-indent'

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

    use 'christoomey/vim-tmux-navigator'

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
    
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'

    use {
	'ray-x/lsp_signature.nvim',
	disable = true,
    }

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
