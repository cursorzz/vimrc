" inspired by https://github.com/Gyufei/MyVimrc
call plug#begin('$HOME/.config/nvim/plugins')
" quick select inner content
Plug 'gcmt/wildfire.vim'

" color scheme
Plug 'gruvbox-community/gruvbox'

" better vim navigation within tmux
Plug 'christoomey/vim-tmux-navigator'

" Plug 'liuchengxu/vim-clap'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

" " file browers
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } " 树形文件查看插件

" " status line
Plug 'itchyny/lightline.vim'                         " 轻量级状态栏优化插件

" " betner replace content, visual mode \"gr\" will replace copied content
Plug 'vim-scripts/ReplaceWithRegister'

" " easy navigate with s + 2chars
" Plug 'justinmk/vim-sneak'

" " better commentary
Plug 'tpope/vim-commentary'                          " 提供简单的快捷注释功能
" personal vim wiki
Plug 'vimwiki/vimwiki'


" Plug 'zhou13/vim-easyescape'


" Plug 'elixir-lang/vim-elixir', {'for': ['elixir', 'eelixir']}


Plug 'ryanoasis/vim-devicons'
set guifont=Inconsolata_Nerd_Font:h12

Plug 'tpope/vim-fugitive'

" Plug 'tpope/vim-eunuch'

" Plug 'wakatime/vim-wakatime'

" Plug 'yggdroot/indentline'

" Plug 'posva/vim-vue'
" Plug 'chriskempson/base16-vim'

" Plug 'liuchengxu/vim-clap'

" Plug 'HerringtonDarkholme/yats.vim'

" " better search result
" Plug 'dyng/ctrlsf.vim'

" new syntaxer
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/telescope.nvim'
" Plug 'nvim-lua/diagnostic-nvim'

" Plug 'hkupty/nvimux'

" Plug 'wincent/terminus'
" Plug 'justinmk/vim-dirvish'
call plug#end()

luafile ~/.config/nvim/init.lua

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

" lua << EOF
" local nvimux = require('nvimux')

" -- Nvimux configuration
" nvimux.config.set_all{
"   prefix = '<C-s>',
"   new_window = 'term', -- Use 'term' if you want to open a new term for every new window
"   new_tab = 'term', -- Defaults to new_window. Set to 'term' if you want a new term for every new tab
"   new_window_buffer = 'single',
"   quickterm_direction = 'botright',
"   quickterm_orientation = 'vertical',
"   quickterm_scope = 't', -- Use 'g' for global quickterm
"   quickterm_size = '80',
" }

" -- Nvimux custom bindings
" nvimux.bindings.bind_all{
"   {'-', ':NvimuxHorizontalSplit', {'n', 'v', 'i', 't'}},
"   {'\\', ':NvimuxVerticalSplit', {'n', 'v', 'i', 't'}},
" }

" -- Required so nvimux sets the mappings correctly
" nvimux.bootstrap()
" EOF
