local actions = require('telescope.actions')
local M = {}

require'telescope'.setup{
  defaults = {
    mappings = {
      i = {
        ["<c-j>"] = actions.move_selection_next,
        ["<c-k>"] = actions.move_selection_previous,
      }
    }
  },
  extensions = {
      fzy_native = {
          override_generic_sorter = false,
          override_file_sorter = true,
      }
  }
}
require('telescope').load_extension('fzy_native')
-- local my_mapping = function(_, map)
--   map("i", '<c-j>', actions.move_selection_next)
--   map("i", '<c-k>', actions.move_selection_previous)
--   return true
-- end
M.search_dotfiles = function() 
  require("telescope.builtin").find_files(
    require('telescope.themes').get_dropdown({
      previewer=false,
      prompt_title = "< VimRC >",
      cwd = "$HOME/.config/nvim",
    })
  )
end

M.find_in_current_folder = function()
  local path = vim.fn.expand("%:p:h")
  require'telescope.builtin'.find_files(
    require('telescope.themes').get_dropdown({
      previewer=false,
      prompt_title = path,
      cwd = path,
    })
  )
end

M.find_files = function()
  require'telescope.builtin'.find_files(
    require('telescope.themes').get_dropdown({
      previewer=false,
    })
  )
end

M.buffers = function()
require'telescope.builtin'.buffers(require('telescope.themes').get_dropdown({previewer=false, show_all_buffers=true}))
end

return M
