return {
    { "lervag/vimtex",      ft = "tex" },
    "elihunter173/dirbuf.nvim",
    "matbme/JABS.nvim",
    {
        "j-hui/fidget.nvim",
        branch = "legacy",
        config = function()
            require("fidget").setup({ text = { spinner = "moon" } })
        end,
    },
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end,
    },
    { "qnighy/lalrpop.vim", ft = "lalrpop" },
    {
        'simrat39/rust-tools.nvim',
        ft = { "rust", "rs" },
        config = function()
            local rt = require("rust-tools")
            rt.setup({
                server = {
                    on_attach = function(_, bufnr)
                        vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
                        vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
                    end,
                },
                tools = {
                    inlay_hints = {
                        auto = false,
                        only_current_line = false,
                    },
                },
            })
        end
    },
    "windwp/nvim-ts-autotag",
    "tpope/vim-fugitive",
    { "ThePrimeagen/git-worktree.nvim" },
    {
        "akinsho/git-conflict.nvim",
        version = "*",
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
    {
        "m-demare/hlargs.nvim",
        config = function()
            require("hlargs").setup()
        end,
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
    { "nvim-lua/plenary.nvim",         lazy = true },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("todo-comments").setup()
        end,
    },
    {
        "folke/trouble.nvim",
        dependencies = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup({})
        end,
    },
    "godlygeek/tabular",
    -- Colorschemes
    "rktjmp/lush.nvim",
    "tjdevries/colorbuddy.vim",
    {
        "phha/zenburn.nvim", -- colorscheme
        lazy = true,
        config = function() require("zenburn").setup() end
    },
    { "RRethy/nvim-base16" },
    {
        "metalelf0/jellybeans-nvim",
        lazy = true,
        config = function()
            vim.cmd("colorscheme jellybeans-nvim")
        end
    },
    {
        "romgrk/doom-one.vim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd("colorscheme doom-one")
        end,
    },
    {
        "folke/tokyonight.nvim",
        lazy = true,
        priority = 1000,
        config = function()
            vim.cmd("colorscheme tokyonight-night")
        end,
    },
    { "rust-lang/rust.vim", ft = { "rust", "rs" } },
    "tpope/vim-surround",
    {
        "akinsho/toggleterm.nvim",
        version = "*",
    },
    {
        "nvim-telescope/telescope.nvim",
        version = "0.1.1",
        dependencies = { { "nvim-lua/plenary.nvim" } },
    },
    { "nvim-telescope/telescope-file-browser.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim",  build = "make" },
    "tpope/vim-commentary",
    "JoosepAlviste/nvim-ts-context-commentstring",
    -- {
    --   "tjdevries/express_line.nvim",
    --   dependencies = { "nvim-lua/plenary.nvim" },
    --   config = function()
    --     require("el").setup({})
    --   end
    -- },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "kyazdani42/nvim-web-devicons", opt = true },
    },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    },
    {
        "gabrielpoca/replacer.nvim",
    },
    { "kyazdani42/nvim-web-devicons", lazy = true },
    "onsails/lspkind.nvim",
    {
        "rmagatti/goto-preview",
    },
    {
        "scalameta/nvim-metals",
        ft = { "scala", "sc" },
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "SmiteshP/nvim-navic",
        dependencies = "neovim/nvim-lspconfig",
    },
    {
        "neovim/nvim-lspconfig",
    },
    "jose-elias-alvarez/null-ls.nvim",
    {
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        ft = { "typescript", "tsx", "tsc", "typescriptreact" },
        config = function()
            require("typescript-tools").setup({
                on_attach = function(client, bufnr)
                    client.server_capabilities.document_formatting = false
                    client.server_capabilities.document_range_formatting = false
                end,
            })
        end
    },
    "jose-elias-alvarez/nvim-lsp-ts-utils",
    "hrsh7th/nvim-cmp",
    { "dcampos/nvim-snippy",          event = "InsertEnter" },
    "dcampos/cmp-snippy",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "nvim-lua/lsp-status.nvim",
}
