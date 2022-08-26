vim.cmd([[packadd packer.nvim]])
return require("packer").startup(function(use)
	-- Util
	use("wbthomason/packer.nvim")
	use("j-hui/fidget.nvim")
	use({ "qnighy/lalrpop.vim", ft = "lalrpop" })
	use("windwp/nvim-ts-autotag")
	use("phaazon/mind.nvim")
	use("tpope/vim-fugitive")
	use({
		"akinsho/git-conflict.nvim",
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
	use({
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
	})
	-- Colorschemes
	use("rktjmp/lush.nvim")
	use("folke/tokyonight.nvim")
	use("tjdevries/colorbuddy.vim")
	use("NTBBloodbath/doom-one.nvim")

	-- Languages
	use("rust-lang/rust.vim")

	-- Workflow
	use("tpope/vim-surround")
	use("voldikss/vim-floaterm")
	use({ "junegunn/fzf", run = "./install --all" })
	use({ "junegunn/fzf.vim" })
	use({ "ibhagwan/fzf-lua", requires = { "kyazdani42/nvim-web-devicons" } })
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
	use("lvimuser/lsp-inlayhints.nvim")
	use({
		"SmiteshP/nvim-navic",
		requires = "neovim/nvim-lspconfig",
	})
	use("neovim/nvim-lspconfig")
	use("jose-elias-alvarez/null-ls.nvim")
	use("jose-elias-alvarez/nvim-lsp-ts-utils")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("nvim-lua/lsp-status.nvim")
end)