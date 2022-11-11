-- nvim tree seems has a bug related to git
-- which makes startup and save extremly slow, see this
-- https://github.com/kyazdani42/nvim-tree.lua/issues/453
--
vim.diagnostic.config(
  {
    virtual_text = false,
    signs = true,
    float = { border = "single" }
  }
)
require("settings/options")
require("settings/mappings")

require("zac.treesitter")
-- require("zac.lsp")
require("zac.compe")
require("zac.cmpe")
require("zac.telescope")
require("zac.neogit")
-- require("zac.hop")
require("zac.mason")
require("zac.null-ls")

require("osc52").setup()

require("gitsigns").setup()
-- require("colorizer").setup(
--   {
--     css = {css = true},
--     html = {css = true},
--     scss = {css = true}
--   }
-- )
require "colorizer".setup()
require("tmux").setup(
  {
    copy_sync = {
      -- enables copy sync and overwrites all register actions to
      -- sync registers *, +, unnamed, and 0 till 9 from tmux in advance
      enable = false
    },
    navigation = {
      -- enables default keybindings (C-hjkl) for normal mode
      enable_default_keybindings = true
    },
    resize = {
      -- enables default keybindings (A-hjkl) for normal mode
      enable_default_keybindings = true
    }
  }
)

-- require("lualine").setup {
--  options = {section_separators = "", component_separators = "", theme = "wombat"},
--  sections = {
--    lualine_c = {
--      {
--        "filename",
--        file_status = true, -- displays file status (readonly status, modified status)
--        path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
--      }
--    }
--  }
--}

require "nvim-treesitter.configs".setup {
  -- textsubjects = {
  --   enable = true,
  --   keymaps = {
  --     ["<cr>"] = "textsubjects-smart"
  --   }
  -- },
  context_commentstring = {
    enable = true,
    enable_autocmd = false
  }
}

require("nvim_comment").setup(
  {
    hook = function()
      require("ts_context_commentstring.internal").update_commentstring()
    end
  }
)

require("neo-tree").setup(
  {
    close_if_last_window = true,
    enable_git_status = false,
    enable_diagnostics = false,
    filesystem = {
      follow_current_file = true,
      window = {
        mappings = {
          ["-"] = "navigate_up"
        }
      }
    },
    window = {
      width = 30
    }
  }
)

-- require("nvim-tree").setup {
--   -- update_to_buf_dir = {
--   --   enable = true
--   -- },
--     update_to_buf_dir = { enable = false },
--   update_focused_file = {
--     enable = false,
--     update_cwd = false,
--     ignore_list = {}
--   },
--   git = {
--     enable = false,
--     ignore = false,
--     timeout = 1
--     --
--   }
-- }

-- vim.g.nvim_tree_show_icons = {
--   git = 0,
--   folders = 1, -- or 0,
--   files = 1, -- or 0,
--   folder_arrows = 1 -- or 0
-- }
-- vim.g.nvim_tree_git_hl = 0tai

-- vim.g.nvim_tree_git_hl = 0
-- vim.g.nvim_tree_gitignore = 0
-- vim.g.nvim_tree_show_icons = {
--   git = 0,
--   folders = 1,
--   files = 1
-- }
-- }

require("indent_blankline").setup {
  char = "|",
  buftype_exclude = { "terminal" }
}

-- local user_group = vim.api.nvim_create_augroup("User", {clear = false})
--

function ReloadConfig(package_name)
  for name, _ in pairs(package.loaded) do
    if name:match("^" .. package_name) then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)

  print(package_name .. " reloaded!")
end

vim.keymap.set(
  "n",
  "<leader>l",
  function()
    ReloadConfig("firework")
  end
)

local home = vim.fn.expand("~/zettelkasten")
require("telekasten").setup(
  {
    home = home
  }
)

vim.keymap.set("n", "<leader>n", require("telekasten").panel, { silent = true })
