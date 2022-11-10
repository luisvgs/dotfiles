local worktree = require("git-worktree")
vim.notify = require("notify")

worktree.on_tree_change(function(op, metadata)
	if op == worktree.Operations.Switch then
		local msg = "Switched from " .. metadata.prev_path .. " to " .. metadata.path
		vim.notify(msg, "info")
	end
end)

worktree.setup({})
