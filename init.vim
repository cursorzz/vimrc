" inspired by https://github.com/Gyufei/MyVimrc
call plug#begin('$HOME/.config/nvim/plugins')
" quick select inner content
Plug 'gcmt/wildfire.vim'

" color scheme
Plug 'gruvbox-community/gruvbox'

" better vim navigation within tmux
Plug 'christoomey/vim-tmux-navigator'

Plug 'liuchengxu/vim-clap'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" file browers
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } " 树形文件查看插件

" status line
Plug 'itchyny/lightline.vim'                         " 轻量级状态栏优化插件

" betner replace content, visual mode \"gr\" will replace copied content
Plug 'vim-scripts/ReplaceWithRegister'

" easy navigate with s + 2chars
Plug 'justinmk/vim-sneak'

" better commentary
Plug 'tpope/vim-commentary'                          " 提供简单的快捷注释功能

Plug 'zhou13/vim-easyescape'


Plug 'elixir-lang/vim-elixir', {'for': ['elixir', 'eelixir']}


Plug 'ryanoasis/vim-devicons'
set guifont=Inconsolata_Nerd_Font:h12

Plug 'tpope/vim-fugitive'

Plug 'tpope/vim-eunuch'

Plug 'wakatime/vim-wakatime'

Plug 'yggdroot/indentline'

Plug 'posva/vim-vue'
Plug 'chriskempson/base16-vim'

Plug 'liuchengxu/vim-clap'

Plug 'HerringtonDarkholme/yats.vim'

" better search result
Plug 'dyng/ctrlsf.vim'


" Plug 'wincent/terminus'
" Plug 'justinmk/vim-dirvish'
call plug#end()

let s:configs = [
   \'basic.vim',
   \'user.vim',
   \'plugin.vim'
   \]

for s:path in s:configs
  exe 'source ' .'~/.config/nvim/conf/'.s:path
endfor
