require("settings/options")
require("lazy").setup(
  {
    {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      config = function()
        vim.cmd([[colorscheme tokyonight]])
      end
    },
    {"nvimtools/none-ls.nvim"},
    {
      "nvim-lua/telescope.nvim"
    },
    {"nvim-tree/nvim-web-devicons", lazy = true},
    {"ojroques/nvim-osc52"},
    {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-vsnip",
        "hrsh7th/vim-vsnip",
        "hrsh7th/vim-vsnip-integ",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua"
      }
    },
    {
      "terrortylor/nvim-comment",
      dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring"
      },
      config = function()
        require("nvim_comment").setup(
          {
            hook = function()
              require("ts_context_commentstring.internal").update_commentstring()
            end
          }
        )
      end
    },
    {
      "lewis6991/gitsigns.nvim",
      config = function()
        require("gitsigns").setup()
      end
    },
    -- [Tab completion]

    {
      "williamboman/mason.nvim",
      dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        "ray-x/lsp_signature.nvim"
      }
    },
    {
      "nvim-treesitter/nvim-treesitter",
      config = function()
        vim.cmd([[TSUpdate]])
      end
    },
    {
      "nvim-lua/telescope.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-fzy-native.nvim",
        "nvim-telescope/telescope-file-browser.nvim"
      }
    },
    "tpope/vim-fugitive",
    {
      "stevearc/oil.nvim",
      config = function()
        require("oil").setup()
        vim.keymap.set("n", "<leader>e", require("oil").open, {desc = "Open Oil directory"})
      end,
      dependencies = {"nvim-tree/nvim-web-devicons"}
    },
    {
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        require("ibl").setup()
      end
    }
  },
  {}
)

require("osc52").setup()
require("zac/telescope")
require("zac/mason")
require("zac/compe")
require("zac/treesitter")
require("zac/null-ls")

vim.diagnostic.config(
  {
    virtual_text = false,
    signs = true,
    float = {border = "single"}
  }
)

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
