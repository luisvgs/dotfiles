return {
	"elihunter173/dirbuf.nvim",
	{
		"vigoux/notifier.nvim",
		enabled = false,
		config = true,
	},
	"j-hui/fidget.nvim",
	"norcalli/nvim-colorizer.lua",
	{ "qnighy/lalrpop.vim", ft = "lalrpop" },
	{ "windwp/nvim-ts-autotag", ft = { "typescript", "jsx", "javascript", "javascriptreact" } },
	"tpope/vim-fugitive",
	{
		"lewis6991/gitsigns.nvim",
		config = true,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	{
		"m-demare/hlargs.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = true,
	},
	"nvim-lua/plenary.nvim",
	{
		"folke/trouble.nvim",
		dependencies = "kyazdani42/nvim-web-devicons",
		config = true,
	},
	-- Lua
	"godlygeek/tabular",
	-- Colorschemes
	"rktjmp/lush.nvim",
	"tjdevries/colorbuddy.vim",
	{
		"NTBBloodbath/doom-one.nvim",
		lazy = false,
		config = function()
			-- Add color to cursor
			vim.g.doom_one_cursor_coloring = false
			-- Set :terminal colors
			vim.g.doom_one_terminal_colors = false
			-- Enable italic comments
			vim.g.doom_one_italic_comments = false
			-- Enable TS support
			vim.g.doom_one_enable_treesitter = false
			-- Color whole diagnostic text or only underline
			vim.g.doom_one_diagnostics_text_color = false
			-- Enable transparent background
			vim.g.doom_one_transparent_background = false

			-- Pumblend transparency
			vim.g.doom_one_pumblend_enable = false
			vim.g.doom_one_pumblend_transparency = 20

			-- Plugins integration
			vim.g.doom_one_plugin_neorg = false
			vim.g.doom_one_plugin_barbar = false
			vim.g.doom_one_plugin_telescope = false
			vim.g.doom_one_plugin_neogit = false
			vim.g.doom_one_plugin_nvim_tree = false
			vim.g.doom_one_plugin_dashboard = false
			vim.g.doom_one_plugin_startify = false
			vim.g.doom_one_plugin_whichkey = false
			vim.g.doom_one_plugin_indent_blankline = false
			vim.g.doom_one_plugin_vim_illuminate = false
			vim.g.doom_one_plugin_lspsaga = false

			vim.cmd([[colorscheme doom-one]])
		end,
	},

	{ "rust-lang/rust.vim", ft = "rust" },
	"tpope/vim-surround",
	"nvim-telescope/telescope-file-browser.nvim",
	"nvim-telescope/telescope-project.nvim",
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	"tpope/vim-commentary",
	"JoosepAlviste/nvim-ts-context-commentstring",
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons", opt = false },
	},
	"windwp/nvim-autopairs",
	{
		"gabrielpoca/replacer.nvim",
	},
	"kyazdani42/nvim-web-devicons",

	-- LSP
	"onsails/lspkind.nvim",
	-- {
	-- 	"rmagatti/goto-preview",
	-- 	config = get_config("goto-preview"),
	-- },
	{
		"scalameta/nvim-metals",
		ft = { "scala", "sc" },
		config = function()
			local api = vim.api
			local metals_config = require("metals").bare_config()

			metals_config.settings = {
				showImplicitArguments = true,
				excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
			}

			metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
			local nvim_metals_group = api.nvim_create_augroup("nvim-metals", { clear = true })

			metals_config.on_attach = function(_, _)
				require("metals")
				require("lsp_signature").on_attach()
				require("lsp-status").on_attach()
				require("nvim-navic").on_attach()
			end

			api.nvim_create_autocmd("FileType", {
				pattern = { "scala", "sbt", "java" },
				callback = function()
					require("metals").initialize_or_attach(metals_config)
				end,
				group = nvim_metals_group,
			})
		end,
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	"lvimuser/lsp-inlayhints.nvim",
	"neovim/nvim-lspconfig",
	"jose-elias-alvarez/null-ls.nvim",
	"jose-elias-alvarez/typescript.nvim",
	"jose-elias-alvarez/nvim-lsp-ts-utils",
	"hrsh7th/nvim-cmp",
	"dcampos/nvim-snippy",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-buffer",
	"nvim-lua/lsp-status.nvim",
}
