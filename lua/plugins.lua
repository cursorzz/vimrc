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
    use "ojroques/vim-oscyank"
    --  https://github.com/lewis6991/gitsigns.nvim
    use "lewis6991/gitsigns.nvim"
    -- use "TimUntersberger/neogit"

    -- [Tab completion]
    use {"hrsh7th/cmp-buffer", requires = {"hrsh7th/nvim-cmp"}}
    use {"hrsh7th/cmp-path", requires = {"hrsh7th/nvim-cmp"}}
    use {"hrsh7th/cmp-vsnip", requires = {"hrsh7th/nvim-cmp", "hrsh7th/vim-vsnip", "hrsh7th/vim-vsnip-integ"}}
    use {"hrsh7th/cmp-nvim-lsp", requires = {"hrsh7th/nvim-cmp"}}

    use "rafamadriz/friendly-snippets" --, { 'branch': 'main'}

    use "terrortylor/nvim-comment" --, {'branch' : 'main'}
    use "JoosepAlviste/nvim-ts-context-commentstring" --, {'branch' : 'main'}

    use "phaazon/hop.nvim"
    use "kyazdani42/nvim-web-devicons"
    use "tpope/vim-fugitive"

    use "wakatime/vim-wakatime"
    use "tjdevries/nlua.nvim"
    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
    use "neovim/nvim-lspconfig"
    use "williamboman/nvim-lsp-installer" -- , { 'branch': 'main'}
    use "nvim-lua/telescope.nvim"
    use "nvim-telescope/telescope-fzy-native.nvim"
    use "nvim-telescope/telescope-file-browser.nvim"
    -- use "rebelot/kanagawa.nvim"
    use "ray-x/lsp_signature.nvim"

    use "nvim-treesitter/nvim-treesitter-textobjects"
    use "RRethy/nvim-treesitter-textsubjects"
    use "nvim-treesitter/playground"

    use "jose-elias-alvarez/null-ls.nvim" --, {'branch': 'main'}
    use "joukevandermaas/vim-ember-hbs"
    use "kchmck/vim-coffee-script"

    use "dyng/ctrlsf.vim"

    -- tree like file browser
    --
    -- use "kyazdani42/nvim-tree.lua"
    use {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v2.x",
      requires = {
        "nvim-lua/plenary.nvim",
        "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim"
      }
    }

    -- use "Tastyep/structlog.nvim" --, {'branch': 'main'}
    use "lukas-reineke/indent-blankline.nvim" --, {'branch': 'master'}

    -- use "folke/zen-mode.nvim" --, {'branch': 'main'}

    -- use "casonadams/walh" --, {'branch': 'main'}
    use {
      "echasnovski/mini.nvim",
      branch = "stable",
      config = function()
        require("mini.statusline").setup({})
        -- require("mini.pairs").setup({})
        -- require("mini.tabline").setup({})
      end
    }
    use "elihunter173/dirbuf.nvim"
  end
)
