vim.cmd([[packadd packer.nvim]])
local function get_config(name)
	return string.format('require("config/%s")', name)
end
return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use("elihunter173/dirbuf.nvim")
	use({ "matbme/JABS.nvim", config = get_config("jabs") })
	use({
		"vigoux/notifier.nvim",
		disable = true,
		config = get_config("notifier"),
	})
	use("j-hui/fidget.nvim")
	use("norcalli/nvim-colorizer.lua")
	use({ "qnighy/lalrpop.vim", ft = "lalrpop" })
	use("windwp/nvim-ts-autotag")
	use("tpope/vim-fugitive")
	use({ "ThePrimeagen/git-worktree.nvim", config = get_config("git-worktree") })
	use({
		"akinsho/git-conflict.nvim",
		tag = "*",
		config = get_config("git-conflict"),
	})
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
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
	use({ "catppuccin/nvim", config = get_config("catpuccin"), as = "catppuccin" })
	use({
		"NTBBloodbath/doom-one.nvim",
		disable = true,
		setup = function()
			-- Add color to cursor
			vim.g.doom_one_cursor_coloring = true
			-- Set :terminal colors
			vim.g.doom_one_terminal_colors = true
			-- Enable italic comments
			vim.g.doom_one_italic_comments = false
			-- Enable TS support
			vim.g.doom_one_enable_treesitter = true
			-- Color whole diagnostic text or only underline
			vim.g.doom_one_diagnostics_text_color = true
			-- Enable transparent background
			vim.g.doom_one_transparent_background = false

			-- Pumblend transparency
			vim.g.doom_one_pumblend_enable = false
			vim.g.doom_one_pumblend_transparency = 20

			-- Plugins integration
			vim.g.doom_one_plugin_neorg = false
			vim.g.doom_one_plugin_barbar = false
			vim.g.doom_one_plugin_telescope = true
			vim.g.doom_one_plugin_neogit = false
			vim.g.doom_one_plugin_nvim_tree = false
			vim.g.doom_one_plugin_dashboard = false
			vim.g.doom_one_plugin_startify = false
			vim.g.doom_one_plugin_whichkey = false
			vim.g.doom_one_plugin_indent_blankline = false
			vim.g.doom_one_plugin_vim_illuminate = false
			vim.g.doom_one_plugin_lspsaga = false
		end,
		config = function()
			vim.cmd("colorscheme doom-one")
		end,
	})

	-- Languages
	use({ "rust-lang/rust.vim", disable = true })

	-- Workflow
	use("tpope/vim-surround")
	use({ "voldikss/vim-floaterm", disable = true })
	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = get_config("toggleterm"),
	})
	use({ "ibhagwan/fzf-lua", disable = true, requires = { "kyazdani42/nvim-web-devicons" } })
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = { { "nvim-lua/plenary.nvim" } },
		config = get_config("telescope"),
	})
	use({ "nvim-telescope/telescope-file-browser.nvim" })
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
		config = get_config("goto-preview"),
	})
	use({
		"scalameta/nvim-metals",
		disable = true,
		config = get_config("metals"),
		requires = { "nvim-lua/plenary.nvim" },
	})
	use("lvimuser/lsp-inlayhints.nvim")
	use({
		"SmiteshP/nvim-navic",
		requires = "neovim/nvim-lspconfig",
	})
	-- Packer
	use("neovim/nvim-lspconfig")
	use("jose-elias-alvarez/null-ls.nvim")
	use({ "jose-elias-alvarez/typescript.nvim" })
	use("jose-elias-alvarez/nvim-lsp-ts-utils")
	use("hrsh7th/nvim-cmp")
	use("dcampos/nvim-snippy")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-buffer")
	use("nvim-lua/lsp-status.nvim")
end)
