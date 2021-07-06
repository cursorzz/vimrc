local actions = require('telescope.actions')
local action_state = require("telescope.actions.state")
local M = {}

require'telescope'.setup{
  defaults = {
    mappings = {
      i = {
        ["<c-j>"] = actions.move_selection_next,
        ["<c-k>"] = actions.move_selection_previous,
        ["<esc>"] = actions.close,
      }
    },
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

        -- return {
          --   prompt = prompt
          -- }
          -- return {
            --   update_finder:
            -- }
    })
  )
end

M.grep_find = function()
  result = vim.fn.expand("<cword>")

  if result == '' then
    result = vim.fn.input("Grep For >")
  end
  require('telescope.builtin').grep_string {
    search = result,
    -- _on_input_filter_cb = function(prompt)
    --   print(prompt)
    --   return {}
    -- end,
    attach_mappings = function(buf, map)
      map('i', '<c-l>', function()
        local picker = action_state.get_current_picker(buf)
        -- print(vim.inspect(picker.manager))
      end)
      return true
    end
  }
end

M.git_files = function()
  require'telescope.builtin'.git_files(
    require('telescope.themes').get_dropdown({
      previewer=false,
      on_input_filter_cb = function(prompt)
        local result = vim.split(prompt, " ")
        if #result == 2 then
          return {
            prompt = result[2]..'.'..result[1]
          }
        else
          return {
            prompt = prompt
          }
        end
        -- print(prompt:match("%s"))
      end
    })
  )
end

M.buffers = function()
  require'telescope.builtin'.buffers(
    require('telescope.themes').get_dropdown({previewer=false, show_all_buffers=true})
  )
end

return M
