require("hop").setup()
--   print("greate", ok)
-- if ok then
--   print("greate")
--   module.setup({})
-- end
local map = vim.keymap.set

map("n", "f", ":HopChar1<CR>"
)
