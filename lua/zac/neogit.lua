local exist, neogit = pcall(require("neogit"))

vim.pretty_print(exist, neogit)

if exist then
  neogit.setup()
end


