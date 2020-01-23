call plug#begin('$HOME/.config/nvim/plugins')
" quick select inner content
Plug 'gcmt/wildfire.vim'

" better vim navigation within tmux
Plug 'christoomey/vim-tmux-navigator'

Plug 'liuchengxu/vim-clap'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()


let s:configs = [
   \'basic.vim',
   \'plugin.vim'
   \]

for s:path in s:configs
  exe 'source ' .'~/.config/nvim/conf/'.s:path
endfor
