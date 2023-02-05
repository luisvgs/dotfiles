local cmp = require("cmp")
local kind = require("lspkind")

vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#98be65" })
vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#ec5f67" })
vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#9CDCFE" })
vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#c678dd" })
vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#FF8800" })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#ECBE7B" })
vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#51afef" })
vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = "#a9a1e1" })

cmp.setup({
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
	},
	snippet = {
		expand = function(args)
			require("snippy").expand_snippet(args.body)
		end,
	},
	formatting = {
		format = kind.cmp_format({ with_text = true, maxwidth = 50 }),
	},
	sources = cmp.config.sources(
		{ { name = "nvim_lsp" } },
		{ { name = "buffer" } },
		{ name = "nvim_lsp_signature_help" },
		{ { name = "snippy" } }
	),
})
