local map = require("utils").map
return {
	"nvim-telescope/telescope.nvim",
	dependencies = "nvim-lua/plenary.nvim",
	config = function()
		require("telescope").setup({
			defaults = {
				layout_strategy = "bottom_pane",
				file_ignore_patterns = {
					".git",
					"node_modules",
					"target",
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
				project = {},
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

		map(
			"n",
			"<C-F>",
			"<cmd>Telescope find_files theme=ivy previewer=false prompt_prefix=🔍 prompt_position='bottom' border=false layout_config={height=0.4}<CR>"
		)
		map(
			"n",
			"<leader>fb",
			"<cmd>Telescope file_browser theme=ivy previewer=false prompt_prefix=🔍 prompt_position='bottom' border=false layout_config={height=0.4}<CR>"
		)
		map("n", "<C-P>", "<cmd>Telescope oldfiles prompt_prefix=🔍 layout_config={height=0.4}<CR>")
		map("n", "<leader>gs", "<cmd> Telescope git_status<CR>")
		map(
			"n",
			"<leader>rg",
			"<cmd>Telescope live_grep theme=ivy prompt_prefix=🔍 find_command=rg border=false prompt_position='bottom' layout_config={height=0.3}<CR>"
		)
		map(
			"n",
			"<leader>gw",
			"<cmd>Telescope git_worktree git_worktrees previewer=false border=false layout_config={height=0.2}<CR>"
		)
		map("n", "<leader>gl", "<cmd>Telescope git_commits border=false layout_config={height=0.3}<CR>")
		map("n", "<leader>op", "<cmd>Telescope project<CR>")
		map(
			"n",
			"<leader>gb",
			"<cmd>Telescope git_branches previewer=false border=false layout_config={height=0.2}<CR>"
		)

		require("telescope").load_extension("file_browser")
		require("telescope").load_extension("fzf")
		require("telescope").load_extension("project")
	end,
}
