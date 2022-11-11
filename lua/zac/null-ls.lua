local ls = require("null-ls")
local h = require("null-ls.helpers")
local methods = require("null-ls.methods")

local FORMATTING = methods.internal.FORMATTING

local lua_fmt =
  h.make_builtin(
  {
    method = FORMATTING,
    filetypes = {"lua"},
    generator_opts = {
      command = "luafmt",
      args = {"--indent-count", 2, "--stdin"},
      to_stdin = true
    },
    factory = h.formatter_factory
  }
)
--
local sources = {
  ls.builtins.formatting.prettierd.with({filetypes = {"javascript", "json", "html", "typescript", "vue"}}),
  lua_fmt
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

require("null-ls").setup(
  {
    on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd(
          "BufWritePre",
          {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format()
            end
          }
        )
      end
    end,
    sources = sources
  }
)

-- local on_attach = function(client)
--   if client.server_capabilities.document_formatting then
--     -- vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.format()")
--
--     -- vim.api.nvim_create_autocmd(
--     --   "BufWritePost",
--     --   {
--     --     pattern = {
--     --       "*"
--     --     },
--     --     command = [[lua vim.lsp.buf.format({async = true})]]
--     --   }
--     -- )
--   end
-- end
--
-- ls.setup({sources = sources, on_attach = on_attach})
