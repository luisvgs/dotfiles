local get_config = require("utils").get_config
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer = require("packer")
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	print("Downloading Packer ...")
	vim.fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.api.nvim_command("packadd packer.nvim")
	require("packer").sync()
end

packer.startup(function(use)
	use("wbthomason/packer.nvim")
	use("lewis6991/impatient.nvim")
	use("dstein64/vim-startuptime")
	use("elihunter173/dirbuf.nvim")
	use({ "voldikss/vim-floaterm", disable = true, config = get_config("floaterm") })
	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = get_config("toggleterm"),
	})
	use({
		"rmagatti/goto-preview",
		config = get_config("goto-preview"),
	})
	use("j-hui/fidget.nvim")
	use({
		"glepnir/dashboard-nvim",
		disable = true,
		event = "VimEnter",
		config = get_config("dashboard"),
	})
	use({ "qnighy/lalrpop.vim", ft = "lalrpop" })
	use("windwp/nvim-ts-autotag")
	use({
		"jose-elias-alvarez/typescript.nvim",
		ft = { "typescript", "typescriptreact" },
		config = get_config("typescript"),
	})
	use("tpope/vim-fugitive")
	use({ "akinsho/git-conflict.nvim" })
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		commit = "42ab95d",
		config = get_config("treesitter"),
	})
	use("nvim-lua/plenary.nvim")
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = get_config("trouble"),
	})
	use("rktjmp/lush.nvim")
	use("RRethy/nvim-base16")
	use("metalelf0/jellybeans-nvim")
	use({
		"phha/zenburn.nvim",
	})
	use("tjdevries/colorbuddy.vim")
	use({ "NvChad/nvim-colorizer.lua", config = get_config("colorizer"), disable = false })
	use({ "folke/tokyonight.nvim", branch = "main" })
	use({
		"NTBBloodbath/doom-one.nvim",
		commit = "60eb78255472bd9a2ca483ce70757cfda57cc706",
		setup = function()
			vim.g.doom_one_cursor_coloring = false
			vim.g.doom_one_terminal_colors = true
			vim.g.doom_one_italic_comments = false
			vim.g.doom_one_enable_treesitter = true
			vim.g.doom_one_diagnostics_text_color = false
			vim.g.doom_one_transparent_background = false
			vim.g.doom_one_pumblend_enable = false
			vim.g.doom_one_pumblend_transparency = 20
			vim.g.doom_one_plugin_neorg = true
			vim.g.doom_one_plugin_barbar = false
			vim.g.doom_one_plugin_telescope = false
			vim.g.doom_one_plugin_neogit = true
			vim.g.doom_one_plugin_nvim_tree = true
			vim.g.doom_one_plugin_dashboard = true
			vim.g.doom_one_plugin_startify = true
			vim.g.doom_one_plugin_whichkey = true
			vim.g.doom_one_plugin_indent_blankline = true
			vim.g.doom_one_plugin_vim_illuminate = true
			vim.g.doom_one_plugin_lspsaga = false
		end,
		config = function()
			vim.cmd("colorscheme doom-one")
		end,
	})
	use({
		"MrcJkb/haskell-tools.nvim",
		ft = { "haskell", "hs" },
		requires = {
			"neovim/nvim-lspconfig",
			"nvim-lua/plenary.nvim",
		},
		config = get_config("haskell-tools"),
	})
	use({
		"scalameta/nvim-metals",
		ft = { "scala", "sc" },
		disable = false,
		config = get_config("metals"),
		requires = { "nvim-lua/plenary.nvim" },
	})
	use("tpope/vim-surround")
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = { { "nvim-lua/plenary.nvim" } },
		config = get_config("telescope"),
	})
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({ "nvim-telescope/telescope-file-browser.nvim" })
	use("ThePrimeagen/git-worktree.nvim")
	use("tpope/vim-commentary")
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use({ "tjdevries/express_line.nvim", disable = true })
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	use("windwp/nvim-autopairs")
	use({
		"gabrielpoca/replacer.nvim",
	})
	use("kyazdani42/nvim-web-devicons")
	use({ "lvimuser/lsp-inlayhints.nvim", disable = false })
	use({ "simrat39/symbols-outline.nvim", config = get_config("symbols_outline") })
	use({
		"onsails/lspkind-nvim",
	})
	use({
		"SmiteshP/nvim-navic",
		requires = "neovim/nvim-lspconfig",
	})
	use("neovim/nvim-lspconfig")
	use({ "jose-elias-alvarez/null-ls.nvim", config = get_config("null-ls") })
	use("jose-elias-alvarez/nvim-lsp-ts-utils")
	use({ "hrsh7th/nvim-cmp", config = get_config("cmp") })
	use("hrsh7th/cmp-nvim-lsp-signature-help")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-buffer")
	use("dcampos/nvim-snippy")
	use("nvim-lua/lsp-status.nvim")
	use({
		"m-demare/hlargs.nvim",
		requires = { "nvim-treesitter/nvim-treesitter" },
	})
end)
