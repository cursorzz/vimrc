set bg=dark                 " 暗色主题
colorscheme gruvbox         " 颜色主题
" set termguicolors
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
