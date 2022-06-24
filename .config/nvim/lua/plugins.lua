vim.cmd([[packadd packer.nvim]])
return require("packer").startup(function(use)
	-- Util
	use("wbthomason/packer.nvim")
	use({
		"akinsho/toggleterm.nvim",
		tag = "v1.*",
		config = function()
			require("toggleterm").setup()
		end,
	})
	use({
		"ThePrimeagen/git-worktree.nvim",
		disable = true,
	})
	use("j-hui/fidget.nvim")
	use({
		"plasticboy/vim-markdown",
		disable = true,
		ft = "markdown",
	})
	use({ "qnighy/lalrpop.vim", ft = "lalrpop" })
	use("windwp/nvim-ts-autotag")
	use("tpope/vim-fugitive")
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("nvim-lua/plenary.nvim")
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({})
		end,
	})
	use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })
	-- Lua
	use("godlygeek/tabular")
	use("rlane/pounce.nvim")

	-- Colorschemes
	use("rktjmp/lush.nvim")
	use("RRethy/nvim-base16")
	use("metalelf0/jellybeans-nvim")
	use("tjdevries/colorbuddy.vim")
	use("folke/tokyonight.nvim")
	use("NTBBloodbath/doom-one.nvim")
	-- If you are using Packer
	use("marko-cerovac/material.nvim")
	-- Languages
	use("rust-lang/rust.vim")

	use({
		"neovimhaskell/haskell-vim",
		ft = "haskell",
	})
	use({
		"alx741/vim-stylishask",
		disable = true,
	})
	use({
		"itchyny/vim-haskell-indent",
		ft = "haskell",
	})
	use({
		"scalameta/nvim-metals",
		disable = true,
		ft = "scala", -- Scala
	})
	use({
		"ckipp01/scala-utils.nvim",
		disable = true,
		ft = "scala",
	})

	-- Workflow
	use("tpope/vim-surround")
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
	use("machakann/vim-highlightedyank")
	use("beauwilliams/focus.nvim")
	use("windwp/nvim-autopairs")
	use({
		"gabrielpoca/replacer.nvim",
	})
	use("kyazdani42/nvim-web-devicons")

	-- LSP
	use({
		"onsails/lspkind-nvim",
		disable = false,
	})
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
	use({
		"nvim-lua/lsp_extensions.nvim",
		disable = true,
		as = "lsp_extensions",
		config = function()
			vim.cmd([[
	    au BufEnter,BufWinEnter,BufWritePost,InsertLeave,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{ prefix = " » " }
	    ]])
		end,
	})
	use("nvim-lua/lsp-status.nvim")
end)
