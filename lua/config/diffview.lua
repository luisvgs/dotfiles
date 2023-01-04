local map = require("utils").map
local diff = require("diffview")

map("n", "<leader>df", ":DiffviewOpen<cr>") -- Compares against the whole index
map("n", "<leader>dc", ":DiffviewClose<cr>") -- Compares against the whole index
map("n", "<leader>dh", ":DiffviewFileHistory %<cr>") -- Compares against the current file
map("n", "<leader>dff", ":DiffviewToggleFiles<cr>") -- Compares against the current file

diff.setup({
	file_history_panel = {
		log_options = {
			single_file = {
				diff_merges = "combined",
			},
			multi_file = {
				diff_merges = "first-parent",
			},
		},
		win_config = {
			position = "bottom",
			height = 12,
		},
	},
	file_panel = {
		listing_style = "tree",
		tree_options = {
			flatten_dirs = true,
			folder_statuses = "only_folded",
		},
		win_config = {
			position = "bottom",
			height = 12,
		},
	},
	view = {
		default = {
			layout = "diff2_horizontal",
		},
		merge_tool = {
			-- layout = "diff1_plain",
			layout = "diff3_mixed",
			disable_diagnostics = true,
		},
		file_history = {
			layout = "diff2_horizontal",
		},
	},
})
