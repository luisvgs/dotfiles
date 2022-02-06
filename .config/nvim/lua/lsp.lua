local lsp = require'lspconfig'
local lsp_status = require'lsp-status'
local null_ls = require'null-ls'

lsp_status.register_progress()
lsp_status.config {
  current_function = false,
  status_symbol = '%#StatusLineLinNbr#LSP',
  indicator_errors = '%#StatusLineLSPErrors#',
  indicator_warnings = '%#StatusLineLSPWarnings#',
  indicator_info = '%#StatusLineLSPInfo#',
  indicator_hints = '%#StatusLineLSPHints#',
  indicator_ok = '%#StatusLineLSPOk#',
}

local lsp_attach = function()
   return function(client, bufnr)
	if client.resolved_capabilities.document_highlight then
	vim.api.nvim_exec([[
	    augroup lsp_document_highlight
	    autocmd! * <buffer>
	    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
	    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
	    autocmd CursorHold * lua vim.diagnostic.open_float(nil, {focus=false})
	    augroup END
	]], false)
	end

	if client.resolved_capabilities.document_formatting then
	    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
	end

	-- if args == nil or args.format == nil or args.format then
	--   vim.api.nvim_exec([[
	--     augroup lsp_formatting_sync
	--       autocmd! * <buffer>
	--       autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
	--     augroup END
	--   ]], false)
	-- end

	lsp_status.on_attach(client)

	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', {})
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>clr', '<cmd>lua vim.lsp.stop_client(vim.lsp.get_active_clients())<cr>', {})
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cd', '<cmd>lua vim.lsp.buf.definition()<cr>', {})
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ch', '<cmd>lua vim.lsp.buf.signature_help()<cr>', {})
	-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gd', '<cmd>lua vim.lsp.buf.declaration()<cr>', {})
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>K', '<cmd>lua vim.lsp.buf.hover()<cr>', {})
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', {})
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', {})
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cn', "<cmd>lua vim.lsp.diagnostic.goto_next()<cr>", {})
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cp', "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>", {})
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>a', "<cmd>lua vim.lsp.buf.code_action()<cr>", {})
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>Telescope lsp_code_actions theme=get_dropdown<cr>', {})
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gr', '<cmd>Telescope lsp_references<cr>', {})
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cs', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', {})
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cx', '<cmd>Telescope lsp_workspace_diagnostics<cr>', {})
	vim.api.nvim_buf_set_keymap(bufnr, 'x', '<leader>ca', '<cmd>Telescope lsp_range_code_actions theme=get_dropdown<cr>', {})
	vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-a>', '<cmd>Telescope lsp_code_actions theme=get_dropdown<cr>', {})
	vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-h>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', {})
    end
end

  -- Setup nvim-cmp.
local cmp = require'cmp'
local kind = require'lspkind'
cmp.setup({
    mapping = {
        ['<C-j'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        })
    },
    formatting = {
        format = kind.cmp_format({with_text = false, maxwidth = 50})
    },
    sources = cmp.config.sources({{ name = 'nvim_lsp' }} , {{ name = 'buffer' } })
})

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
vim.tbl_extend('keep', capabilities, lsp_status.capabilities)

-- Haskell.
lsp.hls.setup {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>hi', '<cmd>belowright 7sp | term ghci %<cr>', {})
    return lsp_attach()(client, bufnr)
end
    ,
    settings = {
	languageServerHaskell = {
	    formattingProvider = "brittany",
        },
    },
}

-- Bash
lsp.bashls.setup {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
	return lsp_attach()(client, bufnr)
    end
}

-- Lua
lsp.sumneko_lua.setup {
    cmd = { "/home/luis/lua-language-server/bin/lua-language-server"},
    capabilities = capabilities,
    settings = {
	Lua = {
	    diagnostics = {
		enable = true,
		globals = { "vim" },
	    },
	},
    },
    on_attach = function(client, bufnr)
	return lsp_attach()(client, bufnr)
    end
}

-- Typescript
null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.code_actions.eslint,
        null_ls.builtins.formatting.prettier
    },
    on_attach = function(client, bufnr)
	return lsp_attach()(client, bufnr)
    end
})

local buf_map = function(bufnr, mode, lhs, rhs, opts)
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
        silent = true,
    })
end

lsp.tsserver.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false        

	local ts_utils = require("nvim-lsp-ts-utils")
        ts_utils.setup({})
        ts_utils.setup_client(client)

	buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
        buf_map(bufnr, "n", "gi", ":TSLspRenameFile<CR>")
        buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")

	return lsp_attach()(client, bufnr)
    end,
})

-- Rust
lsp.rust_analyzer.setup {
  capabilities = capabilities,
  cmd = { "rust-analyzer"},
  settings = {
    ["rust-analyzer"] = {
        assist = {
            importGranularity = "module",
            importPrefix = "by_self",
        },

      checkOnSave = {
        enable = false,
        allFeatures = false,
      },

      completion = {
        addCallArgumentSnippets = true,
        addCallParenthesis = true,
        postfix = {
          enable = true,
        },
        autoimport = {
          enable = false,
        },
      },

      diagnostics = {
        enable = true,
        enableExperimental = true,
      },

      inlayHints = {
        chainingHints = false,
        parameterHints = true,
        typeHints = true,
      },

      procMacro = {
        enable = true,
      },
    },
  },

  flags = {
      debounce_text_changes = 150,
  },

  on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cb', '<cmd>belowright 10sp | term cargo build<cr>', {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cc', '<cmd>belowright 10sp | term cargo clippy<cr>', {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>br', '<cmd>belowright 10sp | term cargo build --release<cr>', {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>db', '<cmd>belowright 10sp | term rustup doc --book<cr>', {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>dd', '<cmd>belowright 10sp | term cargo doc --open<cr>', {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>ds', '<cmd>belowright 10sp | term rustup doc --std<cr>', {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cr', '<cmd>belowright 10sp | term cargo run<cr>', {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ct', '<cmd>belowright 10sp | term cargo t<cr>', {})

    return lsp_attach()(client, bufnr)
  end
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = false,
    virtual_text = false,
    signs = true,
    update_in_insert = false,
  }
)

vim.fn.sign_define(
  'DiagnosticSignError',
  { text = '█', texthl = 'DiagnosticSignError' }
)

vim.fn.sign_define(
  'DiagnosticSignWarn',
  { text = '█', texthl = 'DiagnosticSignWarn' }
)

vim.fn.sign_define(
  'DiagnosticSignInfo',
  { text = '█', texthl = 'DiagnosticSignInfo' }
)

vim.fn.sign_define(
  'DiagnosticSignHint',
  { text = '█', texthl = 'DiagnosticSignHint' }
)
