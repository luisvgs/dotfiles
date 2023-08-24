return {
  "hrsh7th/nvim-cmp",
  config = function()
    local cmp = require("cmp")
    local kind = require("lspkind")
    cmp.setup({
      mapping = {
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
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
        { { name = "snippy", keyword_length = 3, max_item_count = 5 } },
        { { name = "path" } }
      ),
      performance = {
        trigger_debounce_time = 500,
        throttle = 550,
        fetching_timeout = 80,
      },
    })
  end,
}
