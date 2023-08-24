local lsp = require("lspconfig")
local lsp_status = require("lsp-status")
local null_ls = require("null-ls")
local navic = require("nvim-navic")
local lsp_attach = require("utils").lsp_attach

lsp_status.register_progress()
lsp_status.config({
  current_function = false,
  status_symbol = "%#StatusLineLinNbr#LSP",
  indicator_errors = "%#StatusLineLSPErrors#",
  indicator_warnings = "%#StatusLineLSPWarnings#",
  indicator_info = "%#StatusLineLSPInfo#",
  indicator_hints = "%#StatusLineLSPHints#",
  indicator_ok = "%#StatusLineLSPOk#",
})

local signs = {
  { name = "DiagnosticSignError", text = "█" },
  { name = "DiagnosticSignWarn",  text = "█" },
  { name = "DiagnosticSignHint",  text = "█" },
  { name = "DiagnosticSignInfo",  text = "█" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

vim.cmd([[
  hi StatusLineLinNbr guibg=#23272e guifg=#51afef
  hi StatusLineLSPOk guibg=#23272e guifg=#98be65
  hi StatusLineLSPErrors guibg=#23272e guifg=#ff6c6b
  hi StatusLineLSPWarnings guibg=#23272e guifg=#ECBE7B
  hi StatusLineLSPInfo guibg=#23272e guifg=#51afef
  hi StatusLineLSPHints guibg=#23272e guifg=#c678dd
]])

vim.diagnostic.config({
  virtual_text = {
    prefix = "",
    spacing = 6,
  },
  float = {
    header = false,
    source = "always",
    border = "rounded",
  },
  signs = true,
  underline = false,
  update_in_insert = false,
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
})

-- Setup nvim-cmp.
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
    fields = { 'menu', 'abbr', 'kind' },
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = 'λ',
        vsnip = '⋗',
        buffer = 'Ω',
        path = '🖫',
      }
      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
  sources = cmp.config.sources(
    { { name = "nvim_lsp" } },
    { { name = "buffer" } },
    { { name = "snippy" } },
    { { name = "path" } }
  ),
})

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
vim.tbl_extend("keep", capabilities, lsp_status.capabilities)

-- Bash
lsp.bashls.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    navic.attach(client, bufnr)
    return lsp_attach()(client, bufnr)
  end,
})

lsp.pyright.setup({
  capabilities = capabilities,
  filetypes = { "python" },
  on_attach = function(client, bufnr)
    navic.attach(client, bufnr)
    return lsp_attach()(client, bufnr)
  end,
})

lsp.ocamllsp.setup({
  cmd = { "ocamllsp" },
  filetypes = { "ocaml", "ocaml.menhir", "ocaml.interface", "ocaml.ocamllex", "reason", "dune" },
  root_dir = lsp.util.root_pattern("*.opam", "esy.json", "package.json", ".git", "dune-project", "dune-workspace"),
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    navic.attach(client, bufnr)
    return lsp_attach()(client, bufnr)
  end,
})

-- lsp.tailwindcss.setup({})

-- Lua
lsp.lua_ls.setup({
  cmd = { "/usr/bin/lua-language-server" },
  capabilities = capabilities,
  settings = {
    Lua = {
      hint = {
        enable = true
      },
      diagnostics = {
        enable = true,
        globals = {
          "vim",
        },
      },
      format = {
        enable = true,
      },
    },
  },
  on_attach = function(client, bufnr)
    navic.attach(client, bufnr)
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false
    return lsp_attach()(client, bufnr)
  end,
})

local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
local event = "BufWritePre" -- or "BufWritePost"
local async = event == "BufWritePost"
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.black,
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.diagnostics.ruff,
    null_ls.builtins.diagnostics.mypy,
    -- filetypes={"javascript", "javascriptreact", "jsx", "tsx", "typescriptreact"}
    null_ls.builtins.formatting.stylua.with({
      extra_args = { "--config-path", vim.fn.expand("../stylua.toml") },
    }),
    null_ls.builtins.formatting.ocamlformat,
  },
  -- capabilities = capabilities,
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.keymap.set("n", "<Leader>f", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = "[lsp] format" })

      -- format on save
      vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
      vim.api.nvim_create_autocmd(event, {
        buffer = bufnr,
        group = group,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, async = async })
        end,
        desc = "[lsp] format on save",
      })
    end

    if client.supports_method("textDocument/rangeFormatting") then
      vim.keymap.set("x", "<Leader>f", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = "[lsp] format" })
    end
  end,
})

-- Rust
-- lsp.rust_analyzer.setup({
--   capabilities = capabilities,
--   cmd = { "rust-analyzer" },
--   settings = {
--     ["rust-analyzer"] = {
--       assist = {
--         importGranularity = "module",
--         importPrefix = "by_self",
--       },

--       checkOnSave = {
--         command = "clippy",
--         enable = false,
--         allFeatures = false,
--       },

--       completion = {
--         addCallArgumentSnippets = true,
--         addCallParenthesis = true,
--         postfix = {
--           enable = true,
--         },
--         autoimport = {
--           enable = false,
--         },
--       },
--       rustfmt = {
--         enableRangeFormatting = true,
--       },

--       diagnostics = {
--         enable = true,
--         enableExperimental = true,
--       },

--       inlayHints = {
--         chainingHints = false,
--         parameterHints = false,
--         typeHints = false,
--       },

--       procMacro = {
--         enable = true,
--       },
--     },
--   },

--   flags = {
--     debounce_text_changes = 150,
--   },

--   on_attach = function(client, bufnr)
--     vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cm", "<cmd>belowright 17sp | term cargo t ::<cr>", {})
--     vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cmq", "<cmd>belowright 17sp | term cargo t -q ::<cr>", {})

--     navic.attach(client, bufnr)

--     local msg = string.format("Language server %s started.", client.name)
--     vim.notify(msg)

--     return lsp_attach()(client, bufnr)
--   end,
-- })
