" inspired by https://github.com/Gyufei/MyVimrc
call plug#begin('$HOME/.config/nvim/plugins')
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
" quick select inner content
" color scheme
Plug 'aserowy/tmux.nvim', { 'branch': 'main'}
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'rafamadriz/friendly-snippets', { 'branch': 'main'}

" [Appearance]
Plug 'hoob3rt/lualine.nvim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'norcalli/nvim-colorizer.lua'

" [Utils]
" betner replace content, visual mode \"gr\" will replace copied content
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'ojroques/vim-oscyank', { 'branch': 'main'}
" https://github.com/lewis6991/gitsigns.nvim
Plug 'lewis6991/gitsigns.nvim', {'branch' : 'main'}

" [Tab completion]
Plug 'hrsh7th/nvim-compe'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

Plug 'tomtom/tcomment_vim'
" " easy navigation tool
" hop is an sneak alternative for easy navigation
Plug 'phaazon/hop.nvim'  
Plug 'kyazdani42/nvim-web-devicons'
Plug 'tpope/vim-fugitive'
Plug 'wakatime/vim-wakatime'
Plug 'tjdevries/nlua.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'kyazdani42/nvim-tree.lua'
" https://github.com/windwp/nvim-spectre
Plug 'windwp/nvim-spectre'
" Plug 'TimUntersberger/neogit'
Plug 'sindrets/diffview.nvim', {'branch': 'main'}
Plug 'ray-x/lsp_signature.nvim'

Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'RRethy/nvim-treesitter-textsubjects'

Plug 'mhartington/formatter.nvim'

Plug 'jose-elias-alvarez/null-ls.nvim', {'branch': 'main'}
Plug 'ray-x/aurora'

call plug#end()

" Plug 'gcmt/wildfire.vim'
" Plug 'lifepillar/vim-gruvbox8'
" Plug 'justinmk/vim-dirvish'
" Plug 'RRethy/nvim-base16'
" Plug 'lukas-reineke/indent-blankline.nvim', {'branch': 'lua'}
" Plug 'dyng/ctrlsf.vim'
"
" a colorscheme
" Plug 'cocopon/iceberg.vim'  
"
" auto pair plugin. not useful currently
" Plug 'steelsojka/pears.nvim'

" Use <Tab> and <S-Tab> to navigate through popup menu
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" nnoremap <silent> gr <cmd>lua require'telescope.builtin'.lsp_references{}<CR>
" nnoremap <silent> <C-g> <cmd>lua require'telescope.builtin'.buffers{}<CR>

" Set completeopt to have a better completion experience
set guifont=Inconsolata_Nerd_Font:h12
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

let s:configs = [
   \'basic.vim',
   \'user.vim'
   \]

for s:path in s:configs
  exe 'source ' .'~/.config/nvim/conf/'.s:path
endfor

luafile ~/.config/nvim/lua/init.lua

function! DoReload(m) abort
  lua require('plenary.reload').reload_module('zac.firework', true)
  lua require('zac.firework').expand(vim.fn.eval("a:m"))
endfunction

nnoremap <CR> :call DoReload("n")<CR>
xnoremap <CR> :<C-U>call DoReload("v")<CR>


