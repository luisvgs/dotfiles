local M = {}

function M.map(mode, lhs, rhs)
	vim.api.nvim_set_keymap(mode, lhs, rhs, { silent = true, noremap = true })
end

function M.get_config(name)
	return string.format('require("config/%s")', name)
end

return M
