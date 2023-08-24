return {
    "nvim-telescope/telescope.nvim",
    config = function()
        local map = require("utils").map
        local telescope = require("telescope")
        telescope.setup({
            pickers = {
                colorscheme = {
                    enable_preview = true
                }
            },
            defaults = {
                layout_strategy = "bottom_pane",
                file_ignore_patterns = {
                    ".git",
                    "_build",
                    "node_modules",
                    "target",
                    "assets",
                    "fonts",
                    "package-lock",
                },
                sorting_strategy = "ascending",
                border = false,
                mappings = {
                    i = {
                        ["<C-j>"] = require("telescope.actions").move_selection_next,
                        ["<C-k>"] = require("telescope.actions").move_selection_previous,
                    },
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
                git_worktree = {},
                file_browser = {
                    theme = "ivy",
                    previewer = false,
                    hijack_netrw = true,
                },
            },
        })

        local TelescopePrompt = {
            TelescopePromptNormal = {
                bg = "#2d3149",
            },
            TelescopePromptBorder = {
                bg = "#2d3149",
            },
            TelescopePromptTitle = {
                fg = "#2d3149",
                bg = "#2d3149",
            },
            TelescopePreviewTitle = {
                fg = "#1F2335",
                bg = "#1F2335",
            },
            TelescopeResultsTitle = {
                fg = "#1F2335",
                bg = "#1F2335",
            },
        }

        for hl, col in pairs(TelescopePrompt) do
            vim.api.nvim_set_hl(0, hl, col)
        end

        telescope.load_extension("file_browser")

        map(
            "n",
            "<C-F>",
            "<cmd>Telescope find_files theme=ivy previewer=false prompt_prefix=λ prompt_position='bottom' border=false layout_config={height=0.3}<CR>"
        )
        map(
            "n",
            "<leader>tc",
            "<cmd>Telescope colorscheme theme=ivy prompt_prefix=λ prompt_position='bottom' border=false layout_config={height=0.3}<CR>"
        )
        map(
            "n",
            "<leader>ff",
            "<cmd>Telescope file_browser theme=ivy previewer=false prompt_prefix=λ prompt_position='bottom' border=false layout_config={height=0.3}<CR>"
        )
        map("n", "<C-P>", "<cmd>Telescope oldfiles prompt_prefix=λ layout_config={height=0.4}<CR>")
        map("n", "<leader>gs", "<cmd> Telescope git_status<CR>")
        map(
            "n",
            "<leader>rg",
            "<cmd>Telescope live_grep theme=ivy prompt_prefix=λ find_command=rg border=false prompt_position='bottom' layout_config={height=0.3}<CR>"
        )
        map(
            "n",
            "<leader>gw",
            "<cmd>Telescope git_worktree git_worktrees previewer=false border=false layout_config={height=0.2}<CR>"
        )
        map("n", "<leader>gl", "<cmd>Telescope git_commits border=false layout_config={height=0.3}<CR>")
        map(
            "n",
            "<leader>gb",
            "<cmd>Telescope git_branches previewer=false border=false layout_config={height=0.2}<CR>"
        )
        map("n", "<leader>ca", "<cmd>Telescope lsp_code_actions theme=get_dropdown<cr>")
        map("n", "<leader>gr", "<cmd>Telescope lsp_references layout_config={height=0.3}<cr>")
        map("n", "<leader>cs", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>")
        map("n", "<leader>td", "<cmd>Telescope diagnostics previewer=false border=false layout_config={height=0.3}<cr>")
    end,
}
