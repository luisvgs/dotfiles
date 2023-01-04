local api = vim.api
local metals_config = require("metals").bare_config()

metals_config.settings = {
	showImplicitArguments = true,
	excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
}

metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
local nvim_metals_group = api.nvim_create_augroup("nvim-metals", { clear = true })
api.nvim_create_autocmd("FileType", {
	-- NOTE: You may or may not want java included here. You will need it if you
	-- want basic Java support but it may also conflict if you are using
	-- something like nvim-jdtls which also works on a java filetype autocmd.
	pattern = { "scala", "sbt", "java" },
	callback = function()
		require("metals").initialize_or_attach(metals_config)
	end,
	group = nvim_metals_group,
})

vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])
