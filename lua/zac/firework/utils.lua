local function t(str)
  -- Adjust boolean arguments as needed
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local exec = function(cmd)
  vim.api.nvim_exec(t(cmd), true)
end
local puts = function(...)
  print(vim.inspect({...}))
end

return {
  t = t,
  exec = exec,
  puts = puts
}
