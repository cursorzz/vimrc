-- require('zac.nvimux')
require('zac.treesitter')
require('zac.lsp')
require('zac.compe')
require('zac.formatter')

require('gitsigns').setup()
require('colorizer').setup()
require('tmux').setup({
  copy_sync = {
    -- enables copy sync and overwrites all register actions to
    -- sync registers *, +, unnamed, and 0 till 9 from tmux in advance
    enable = true,
  },
  navigation = {
    -- enables default keybindings (C-hjkl) for normal mode
    enable_default_keybindings = true,
  },
  resize = {
    -- enables default keybindings (A-hjkl) for normal mode
    enable_default_keybindings = true,
  }
})
-- require'lsp_signature'.on_attach()
--
-- require('neogit').setup()
local cb = require'diffview.config'.diffview_callback

require'diffview'.setup {
  diff_binaries = false,    -- Show diffs for binaries
  file_panel = {
    width = 35,
    use_icons = false        -- Requires nvim-web-devicons
  },
  key_bindings = {
    disable_defaults = false,                   -- Disable the default key bindings
    -- The `view` bindings are active in the diff buffers, only when the current
    -- tabpage is a Diffview.
    view = {
      ["<tab>"]     = cb("select_next_entry"),  -- Open the diff for the next file 
      ["<s-tab>"]   = cb("select_prev_entry"),  -- Open the diff for the previous file
      ["<leader>e"] = cb("focus_files"),        -- Bring focus to the files panel
      ["<leader>b"] = cb("toggle_files"),       -- Toggle the files panel.
    },
    file_panel = {
      ["j"]             = cb("next_entry"),         -- Bring the cursor to the next file entry
      ["k"]             = cb("prev_entry"),         -- Bring the cursor to the previous file entry.
      ["<cr>"]          = cb("select_entry"),       -- Open the diff for the selected entry.
      ["-"]             = cb("toggle_stage_entry"), -- Stage / unstage the selected entry.
      ["S"]             = cb("stage_all"),          -- Stage all entries.
      ["U"]             = cb("unstage_all"),        -- Unstage all entries.
      ["R"]             = cb("refresh_files"),      -- Update stats and entries in the file list.
      ["<tab>"]         = cb("select_next_entry"),
      ["<s-tab>"]       = cb("select_prev_entry"),
      ["<leader>e"]     = cb("focus_files"),
      ["<leader>b"]     = cb("toggle_files"),
    }
  }
}

require('lualine').setup {
 options = {section_separators = '', component_separators = '', theme = 'wombat'};
 sections = {
   lualine_c = {
    {
      'filename',
      file_status = true, -- displays file status (readonly status, modified status)
      path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
    }
  }
 }
}

require'nvim-treesitter.configs'.setup {
  textsubjects = {
    enable = true,
    keymaps = {
      ['<cr>'] = 'textsubjects-smart',
    }
  },
}

-- require('base16-colorscheme').setup({
--     base00 = '#16161D', base01 = '#3e4451', base02 = '#2c313c', base03 = '#565c64',
--     base04 = '#6c7891', base05 = '#abb2bf', base06 = '#9a9bb3', base07 = '#c5c8e6',
--     base08 = '#e06c75', base09 = '#d19a66', base0A = '#45c07b', base0B = '#98c379',
--     base0C = '#56b6c2', base0D = '#0184bc', base0E = '#c678dd', base0F = '#a06949',
-- })
