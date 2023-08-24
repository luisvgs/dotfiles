return {
	"rmagatti/goto-preview",
	config = function()
		local goto_preview = require("goto-preview")

		goto_preview.setup({ default_mappings = true, height = 25 })
	end,
}
