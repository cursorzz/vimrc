-- Setup nvim-cmp.
local cmp = require "cmp"

cmp.setup(
  {
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end
    },
    mapping = {
      ["<C-j>"] = cmp.mapping.select_next_item(),
      ["<C-k>"] = cmp.mapping.select_prev_item(),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<ESC>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({select = true})
    },
    sources = {
      {name = "nvim_lsp"},
      {name = "vsnip"},
      {
        name = "buffer",
        option = {
          get_bufnrs = function()
            return vim.api.nvim_list_bufs()
          end
        }
      },
      {name = "path"}
    }
  }
)
