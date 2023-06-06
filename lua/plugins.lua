local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap =
    fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
end

vim.api.nvim_create_autocmd(
  {"BufWritePost"},
  {
    pattern = vim.fn.expand("~/.config/nvim/lua/plugins.lua"),
    command = "source <afile> | PackerCompile"
  }
)

-- related autocmd
vim.api.nvim_create_autocmd(
  "User",
  {
    pattern = "PackerComplete",
    callback = function(a)
      print(vim.inspect(a))
      print("packer task done")
    end
    -- group = 'User',
    -- pattern = "*"
  }
)

vim.api.nvim_create_autocmd(
  "User",
  {
    pattern = "PackerCompileDone",
    callback = function(a)
      print(vim.inspect(a))
      print("packer compile finish")
    end
    -- group = 'User',
    -- pattern = "*"
  }
)

vim.loader.enable()

return require("packer").startup(
  function(use)
    use "wbthomason/packer.nvim"

    use "nvim-lua/popup.nvim"
    use "nvim-lua/plenary.nvim"
    use "aserowy/tmux.nvim"

    -- use "hoob3rt/lualine.nvim"
    use "folke/tokyonight.nvim"
    use "norcalli/nvim-colorizer.lua"

    -- [Utils]
    -- betner replace content, visual mode \"gr\" will replace copied content
    use "vim-scripts/ReplaceWithRegister"

    use "ojroques/nvim-osc52"

    --  https://github.com/lewis6991/gitsigns.nvim
    use "lewis6991/gitsigns.nvim"

    use {"TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim"}

    -- [Tab completion]
    use {"hrsh7th/cmp-buffer", requires = {"hrsh7th/nvim-cmp"}}
    use {"hrsh7th/cmp-path", requires = {"hrsh7th/nvim-cmp"}}
    use {"hrsh7th/cmp-vsnip", requires = {"hrsh7th/nvim-cmp", "hrsh7th/vim-vsnip", "hrsh7th/vim-vsnip-integ"}}
    use {"hrsh7th/cmp-nvim-lsp", requires = {"hrsh7th/nvim-cmp"}}
    use {"hrsh7th/cmp-nvim-lua", requires = {"hrsh7th/nvim-cmp"}}

    use "rafamadriz/friendly-snippets" --, { 'branch': 'main'}

    use "terrortylor/nvim-comment" --, {'branch' : 'main'}
    use "JoosepAlviste/nvim-ts-context-commentstring" --, {'branch' : 'main'}

    use {"phaazon/hop.nvim"}
    use "kyazdani42/nvim-web-devicons"
    use "tpope/vim-fugitive"

    use "wakatime/vim-wakatime"
    use "tjdevries/nlua.nvim"
    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
    -- use "williamboman/nvim-lsp-installer" -- , { 'branch': 'main'}
    use "nvim-lua/telescope.nvim"
    use "nvim-telescope/telescope-fzy-native.nvim"
    use "nvim-telescope/telescope-file-browser.nvim"
    -- use "rebelot/kanagawa.nvim"
    use {"ray-x/lsp_signature.nvim", disable = true}

    use "nvim-treesitter/nvim-treesitter-textobjects"
    use "RRethy/nvim-treesitter-textsubjects"
    use "nvim-treesitter/playground"

    use "jose-elias-alvarez/null-ls.nvim" --, {'branch': 'main'}

    use "dyng/ctrlsf.vim"

    use "samoshkin/vim-mergetool"

    use "folke/neodev.nvim"

    use {
      "akinsho/git-conflict.nvim",
      tag = "*",
      config = function()
        require("git-conflict").setup(
          {
            default_mappings = {
              ours = "o",
              theirs = "t",
              none = "0",
              both = "b",
              next = "n",
              prev = "p"
            }
          }
        )
      end
    }

    -- tree like file browser
    --
    -- use "kyazdani42/nvim-tree.lua"
    -- use {
    --   "nvim-neo-tree/neo-tree.nvim",
    --   branch = "v2.x",
    --   requires = {
    --     "nvim-lua/plenary.nvim",
    --     "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
    --     "MunifTanjim/nui.nvim"
    --   }
    -- }

    -- use "Tastyep/structlog.nvim" --, {'branch': 'main'}
    use "lukas-reineke/indent-blankline.nvim" --, {'branch': 'master'}

    -- use "folke/zen-mode.nvim" --, {'branch': 'main'}

    -- use "casonadams/walh" --, {'branch': 'main'}
    -- use {
    --   "echasnovski/mini.nvim",
    --   branch = "stable",
    --   config = function()
    --     require("mini.statusline").setup({})
    --     -- require("mini.pairs").setup({})
    --     -- require("mini.tabline").setup({})
    --   end
    -- }
    -- use "elihunter173/dirbuf.nvim"

    -- use {
    --   "lewis6991/impatient.nvim",
    --   config = function()
    --     require("impatient")
    --   end
    -- }

    -- 弃用, 一旦出现错误会打乱原先的布局, 不能忍
    -- use(
    --   {
    --     "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    --     config = function()
    --       require("lsp_lines").register_lsp_virtual_lines()
    --     end,
    --     disable = true
    --   }
    -- )
    -- use {
    --   "nvim-orgmode/orgmode",
    --   config = function()
    --     require("orgmode").setup {}
    --   end
    -- }

    use "renerocksai/telekasten.nvim"

    use(
      {
        "iamcco/markdown-preview.nvim",
        run = function()
          vim.fn["mkdp#util#install"]()
        end
      }
    )

    use {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig"
    }

    use "kdheepak/lazygit.nvim"

    if vim.fn.has("linux") then
      use "joukevandermaas/vim-ember-hbs"
      use "kchmck/vim-coffee-script"
    end

    use {"ibhagwan/smartyank.nvim"}

    use {"github/copilot.vim"}
    use {"Exafunction/codeium.vim", disable = true}

    use(
      {
        "glepnir/lspsaga.nvim",
        branch = "main",
        config = function()
          require("lspsaga").setup(
            {
              lightbulb = {
                enable = false,
                enable_in_insert = false
              },
              symbol_in_winbar = {
                enable = false
              }
            }
          )
        end,
        requires = {{"nvim-tree/nvim-web-devicons"}}
      }
    )

    use {
      "stevearc/oil.nvim",
      config = function()
        require("oil").setup()
      end,
      requires = {{"nvim-tree/nvim-web-devicons"}}
    }

    if packer_bootstrap then
      require("packer").sync()
    end
  end
)
