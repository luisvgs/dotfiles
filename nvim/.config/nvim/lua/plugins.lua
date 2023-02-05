vim.cmd([[packadd packer.nvim]])
local function get_config(name)
	return string.format('require("config/%s")', name)
end
return require("packer").startup(function(use)
	-- Util
	use("wbthomason/packer.nvim")
	use({ "rcarriga/nvim-notify", disable = true, config = get_config("notify") })
	use("elihunter173/dirbuf.nvim")
	use({
		"rmagatti/goto-preview",
	})
	use("j-hui/fidget.nvim")
	use({ "qnighy/lalrpop.vim", ft = "lalrpop" })
	use("windwp/nvim-ts-autotag")
	use("tpope/vim-fugitive")
	use({ "ThePrimeagen/git-worktree.nvim", config = get_config("git-worktree") })
	use({
		"akinsho/git-conflict.nvim",
		tag = "*",
	})
	use({
		"lewis6991/gitsigns.nvim",
		config = get_config("gitsigns"),
	})
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
	-- Colorschemes
	use("rktjmp/lush.nvim")
	use({ "NvChad/nvim-colorizer.lua", config = get_config("colorizer") })
	use("tjdevries/colorbuddy.vim")
	use({ "catppuccin/nvim", config = get_config("catpuccin"), as = "catppuccin" })
	use({
		"NTBBloodbath/doom-one.nvim",
		disable = true,
		config = get_config("doom"),
	})
	use("metalelf0/jellybeans-nvim")
	-- Languages
	use({ "rust-lang/rust.vim", ft = { "rust" }, config = get_config("rust") })

	use({
		"scalameta/nvim-metals",
		config = get_config("metals"),
		disable = false,
		requires = { "nvim-lua/plenary.nvim" },
	})
	-- Workflow
	use("tpope/vim-surround")
	use("tpope/vim-commentary")
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = { { "nvim-lua/plenary.nvim" } },
		config = get_config("telescope"),
	})
	use({ "nvim-telescope/telescope-file-browser.nvim" })
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

	use("JoosepAlviste/nvim-ts-context-commentstring")
	use({ "tjdevries/express_line.nvim", disable = true })
	use("voldikss/vim-floaterm")
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	use("machakann/vim-highlightedyank")
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
	use({ "jose-elias-alvarez/null-ls.nvim", config = get_config("null-ls") })
	use({ "jose-elias-alvarez/typescript.nvim", config = get_config("typescript") })
	use("jose-elias-alvarez/nvim-lsp-ts-utils")
	use({ "hrsh7th/nvim-cmp", config = get_config("cmp") })
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lsp-signature-help")
	use("hrsh7th/cmp-buffer")
	use("dcampos/nvim-snippy")
	use("nvim-lua/lsp-status.nvim")
end)
