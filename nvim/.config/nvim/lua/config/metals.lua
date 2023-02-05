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
