" inspired by https://github.com/Gyufei/MyVimrc
call plug#begin('$HOME/.config/nvim/plugins')
" quick select inner content
Plug 'gcmt/wildfire.vim'

" color scheme
" Plug 'gruvbox-community/gruvbox'
Plug 'lifepillar/vim-gruvbox8'

" better vim navigation within tmux
Plug 'christoomey/vim-tmux-navigator'

" Plug 'liuchengxu/vim-clap'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

" " file browers
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } " 树形文件查看插件

" " status line
" Plug 'itchyny/lightline.vim'                         " 轻量级状态栏优化插件
Plug 'hoob3rt/lualine.nvim'

" " betner replace content, visual mode \"gr\" will replace copied content
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

" " easy navigate with s + 2chars
" Plug 'justinmk/vim-sneak'

" " better commentary
Plug 'tpope/vim-commentary'                          " 提供简单的快捷注释功能
" personal vim wiki
Plug 'vimwiki/vimwiki'
Plug 'christianchiarulli/nvcode-color-schemes.vim'

" Plug 'jiangmiao/auto-pairs'

" Plug 'karb94/neoscroll.nvim'
Plug 'ojroques/vim-oscyank', { 'branch': 'main'}


Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue'] }



" Plug 'zhou13/vim-easyescape'


" Plug 'elixir-lang/vim-elixir', {'for': ['elixir', 'eelixir']}


Plug 'ryanoasis/vim-devicons'
set guifont=Inconsolata_Nerd_Font:h12

Plug 'tpope/vim-fugitive'
" Plug 'airblade/vim-gitgutter'

" Plug 'tpope/vim-eunuch'

Plug 'wakatime/vim-wakatime'

Plug 'TimUntersberger/neogit'

" Plug 'yggdroot/indentline'

" Plug 'posva/vim-vue'
" Plug 'chriskempson/base16-vim'

" Plug 'liuchengxu/vim-clap'

" " better search result
Plug 'dyng/ctrlsf.vim'

" new syntaxer
Plug 'tjdevries/nlua.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
" Plug 'code-biscuits/nvim-biscuits'
" Plug 'nvim-lua/completion-nvim'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/telescope.nvim'
Plug 'hrsh7th/nvim-compe'

Plug 'kyazdani42/nvim-tree.lua'
" https://github.com/windwp/nvim-spectre
Plug 'windwp/nvim-spectre'

" Plug 'kyazdani42/nvim-tree.lua'

Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'cocopon/iceberg.vim'

Plug 'ray-x/lsp_signature.nvim'
Plug 'hoob3rt/lualine.nvim'

Plug 'steelsojka/pears.nvim'

" Plug 'dyng/ctrlsf.vim'
" https://github.com/lewis6991/gitsigns.nvim
Plug 'lewis6991/gitsigns.nvim', {'branch' : 'main'}

" Plug 'lukas-reineke/indent-blankline.nvim', {'branch': 'lua'}
Plug 'norcalli/nvim-colorizer.lua'


Plug 'hkupty/nvimux'

" Plug 'wincent/terminus'
Plug 'justinmk/vim-dirvish'
call plug#end()


" Use <Tab> and <S-Tab> to navigate through popup menu
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" nnoremap <silent> gr <cmd>lua require'telescope.builtin'.lsp_references{}<CR>
" nnoremap <silent> <C-g> <cmd>lua require'telescope.builtin'.buffers{}<CR>

" Set completeopt to have a better completion experience
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
