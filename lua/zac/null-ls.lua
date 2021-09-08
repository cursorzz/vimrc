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

local sources = {
  ls.builtins.formatting.prettier,
  lua_fmt
  -- ls.builtins.formatting.gofmt
}

ls.config({sources = sources})
