local M = {}

M.git_files = function()
  require('telescope.builtin').git_files{
    previewer = false,
    width = 90,
    shorten_path = false,
    winblend= 10,
    height= 10,
    max_results = 10
  }
end

return M
