local ok, module = pcall(require, "hop")
if ok then
  module.setup()
  local map = vim.keymap.set

  map("n", "f", ":HopChar1<CR>", {silent= true}
  )
end
