vim.cmd([[packadd packer.nvim]])
return require("packer").startup(function(use)
	-- Util
	use("wbthomason/packer.nvim")
	use("elihunter173/dirbuf.nvim")
	use("rcarriga/nvim-notify")
	use("j-hui/fidget.nvim")
	use("norcalli/nvim-colorizer.lua")
	use({ "qnighy/lalrpop.vim", ft = "lalrpop" })
	use("windwp/nvim-ts-autotag")
	use("tpope/vim-fugitive")
	use("ThePrimeagen/git-worktree.nvim")
	use({
		"akinsho/git-conflict.nvim",
		tag = "*",
	})
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use({
		"m-demare/hlargs.nvim",
		requires = { "nvim-treesitter/nvim-treesitter" },
	})
	use("nvim-lua/plenary.nvim")
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({})
		end,
	})
	-- Lua
	use("godlygeek/tabular")
	-- Colorschemes
	use("rktjmp/lush.nvim")
	use({ "folke/tokyonight.nvim", branch = "main" })
	use("tjdevries/colorbuddy.vim")
	use("romgrk/doom-one.vim")
	use("sainnhe/edge")

	-- Languages
	use("rust-lang/rust.vim")

	-- Workflow
	use("tpope/vim-surround")
	use("voldikss/vim-floaterm")
	use({ "ibhagwan/fzf-lua", disable = true, requires = { "kyazdani42/nvim-web-devicons" } })
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use("tpope/vim-commentary")
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use({ "tjdevries/express_line.nvim", disable = true })
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	-- use("machakann/vim-highlightedyank")
	use({ "beauwilliams/focus.nvim", disable = true })
	use("windwp/nvim-autopairs")
	use({
		"gabrielpoca/replacer.nvim",
	})
	use("kyazdani42/nvim-web-devicons")

	-- LSP
	use("onsails/lspkind.nvim")
	use({
		"rmagatti/goto-preview",
	})
	use("lvimuser/lsp-inlayhints.nvim")
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
	})
	use({
		"SmiteshP/nvim-navic",
		requires = "neovim/nvim-lspconfig",
	})
	-- Packer
	use("neovim/nvim-lspconfig")
	use("jose-elias-alvarez/null-ls.nvim")
	use("jose-elias-alvarez/nvim-lsp-ts-utils")
	use("hrsh7th/nvim-cmp")
	use("dcampos/nvim-snippy")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-buffer")
	use("nvim-lua/lsp-status.nvim")
end)
