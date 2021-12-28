require'nvim-treesitter.configs'.setup{
    incremental_selection = {
	enable = true,
	keymaps = {
	    init_selection = '<CR>',
	    scope_incremental = '<CR>',
	    node_incremental = '<TAB>',
	    node_decremental = '<S-TAB>',
	},
    },
    highlight = {
	enable = true,
    },
    indent = {
	enabled = false,
    },
    textobjects = {
	enable = true
    },

}
