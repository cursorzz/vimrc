local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local fb_actions = require("telescope").extensions.file_browser.actions
-- print(vim.inspect(fb_actions))
local M = {}
local default_theme =
  require("telescope.themes").get_dropdown(
  {
    mappings = {
      i = {
        ["<c-j>"] = actions.move_selection_next,
        ["<c-k>"] = actions.move_selection_previous,
        ["<esc>"] = actions.close
      }
    }
  }
)
require "telescope".setup {
  defaults = default_theme,
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true
    },
    file_browser = {
      previewer = false,
      -- initial_mode = "normal",
      theme = "dropdown",
      mappings = {
        i = {
          ["<c-j>"] = actions.move_selection_next,
          ["<c-k>"] = actions.move_selection_previous,
          ["<c-h>"] = fb_actions.goto_parent_dir,
          ["<c-l>"] = actions.select_default,
          ["<c-a>"] = fb_actions.create,
          ["<c-r>"] = fb_actions.rename,
          ["<esc>"] = actions.close
        }
      }
    }
  }
}

-- mappings = {
--   ["i"] = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<c-h>"] = fb_actions.goto_parent_dir,
--     ["<c-d>"] = fb_actions.remove_file,
--     ["<c-n>"] = fb_actions.create_file
--     -- ["<esc>"] = actions.close
--   }
--   -- ["c"] = fb_actions.create_file,
--   -- ["r"] = fb_actions.rename_file,
--   -- ["<cr>"] = fb_actions.open_file
-- }

require("telescope").load_extension("fzy_native")
require("telescope").load_extension "file_browser"

M.search_dotfiles = function()
  require("telescope.builtin").find_files(
    {
      previewer = false,
      prompt_title = "< VimRC >",
      cwd = "$HOME/.config/nvim"
    }
  )
end

local function to_parent_folder(buf, map)
end

-- override builtins

M.find_in_current_folder = function()
  local path = vim.fn.expand("%:p:h")
  require "telescope.builtin".file_browser(
    {
      previewer = false,
      prompt_title = path,
      cwd = path
    }
  )
end

M.find_files = function()
  require "telescope.builtin".find_files(
    require("telescope.themes").get_dropdown(
      {
        previewer = false
      }
    )
  )
end

M.grep_find = function()
  result = vim.fn.expand("<cword>")

  if result == "" then
    result = vim.fn.input("Grep For >")
  end
  require("telescope.builtin").grep_string {
    search = result,
    attach_mappings = function(buf, map)
      map(
        "i",
        "<c-l>",
        function()
          actions.send_to_qflist(buf)
          actions.open_qflist()
        end
      )
      return true
    end
  }
end

M.git_files = function()
  require "telescope.builtin".git_files(
    {
      previewer = false,
      on_input_filter_cb = function(prompt)
        local result = vim.split(prompt, " ")
        if #result == 2 then
          return {
            prompt = result[2] .. "." .. result[1]
          }
        else
          return {
            prompt = prompt
          }
        end
        -- print(prompt:match("%s"))
      end
    }
  )
end

M.buffers = function()
  require "telescope.builtin".buffers({previewer = false, show_all_buffers = true})
end

return M
