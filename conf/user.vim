set bg=dark                 " 暗色主题
" colorscheme gruvbox         " 颜色主题
colorscheme Tomorrow-Night-Eighties         " 颜色主题
set termguicolors
" colorscheme base16-default-dark

" use hgtgt
inoremap hh <ESC>
cnoremap hh <ESC>
tnoremap hh <ESC>

" easy choose tabs         
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

:vmap u <Nop>

" close other tabs
nnoremap <Leader>c :tabonly<CR>

nnoremap <C-f> <cmd>lua require'telescope.builtin'.git_files{}<CR>
nnoremap <C-p> <cmd>lua require'telescope.builtin'.live_grep{}<CR>


" NERDTree config
noremap <Leader>t :NERDTreeToggle<CR>
noremap <Leader>e :NERDTreeFind<CR>

nnoremap <Leader>vi :e $MYVIMRC<CR> 
nnoremap <Leader>vr :source $MYVIMRC<CR> 

function! ToggleNerdTree() abort
  let isOpen = get(g:, 'NERDTree.IsOpen', 0)
  echom isOpen
  if isOpen == 0
    :NERDTreeToggle
    :NERDTreeFind
  else
    :NERDTreeToggle
  endif
endfunction
