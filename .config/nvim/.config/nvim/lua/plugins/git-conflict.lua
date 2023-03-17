return {
	"akinsho/git-conflict.nvim",
	config = function()
		require("git-conflict").setup({
			default_mappings = true,
			disable_diagnostics = false,
			highlights = {
				incoming = "DiffText",
				current = "DiffAdd",
			},
		})
	end,
}
