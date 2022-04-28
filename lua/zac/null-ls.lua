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

local on_attach = function(client)
  if client.resolved_capabilities.document_formatting then
    vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting_sync()")
  end
end
--
ls.setup({sources = sources, on_attach = on_attach})
