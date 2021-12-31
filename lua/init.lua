-- nvim tree seems has a bug related to git
-- which makes startup and save extremly slow, see this
-- https://github.com/kyazdani42/nvim-tree.lua/issues/453

require("zac.treesitter")
require("zac.null-ls")
require("zac.lsp")
require("zac.compe")

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

require("lualine").setup {
  options = {section_separators = "", component_separators = "", theme = "wombat"},
  sections = {
    lualine_c = {
      {
        "filename",
        file_status = true, -- displays file status (readonly status, modified status)
        path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
      }
    }
  }
}

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

require("nvim-tree").setup {
  -- update_to_buf_dir = {
  --   enable = true
  -- },
  update_focused_file = {
    enable = false,
    update_cwd = false,
    ignore_list = {}
  },
  git = {
    enable = false,
    ignore = false,
    timeout = 1
    --
  }
}

vim.g.nvim_tree_show_icons = {
  git = 0,
  folders = 1, -- or 0,
  files = 1, -- or 0,
  folder_arrows = 1 -- or 0
}
-- vim.g.nvim_tree_git_hl = 0

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
  buftype_exclude = {"terminal"}
}
