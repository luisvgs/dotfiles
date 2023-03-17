return {
	"ThePrimeagen/git-worktree.nvim",
	config = function()
		local worktree = require("git-worktree")
		worktree.on_tree_change(function(op, metadata)
			if op == worktree.Operations.Switch then
				local msg = "Switched from " .. metadata.prev_path .. " to " .. metadata.path
				vim.notify(msg)
			end
		end)

		worktree.setup({})
	end,
}
