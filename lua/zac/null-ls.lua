local ls = require("null-ls")

local sources = {
  ls.builtins.formatting.prettier,
  -- ls.builtins.formatting.gofmt
}

ls.config({sources = sources})

