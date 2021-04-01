set bg=dark                 " 暗色主题
" colorscheme gruvbox         " 颜色主题
" colorscheme Tomorrow-Night-Eighties         " 颜色主题
" colorscheme palenight
" colorscheme lunar
colorscheme iceberg
set termguicolors
" colorscheme base16-default-dark

" use hgtgt
inoremap hh <ESC>
cnoremap hh <ESC>
tnoremap hh <ESC>

" easy choose tabs         
" noremap <leader>1 1gt
" noremap <leader>2 2gt
" noremap <leader>3 3gt
" noremap <leader>4 4gt
" noremap <leader>5 5gt
" noremap <leader>6 6gt
" noremap <leader>7 7gt
" noremap <leader>8 8gt
" noremap <leader>9 9gt
" noremap <leader>0 :tablast<cr>

:vmap u <Nop>



" close other tabs
nnoremap <Leader>c :tabonly<CR>

nnoremap <C-f> <cmd>lua require'zac.telescope'.find_files()<CR>
nnoremap <C-g> <cmd>lua require'zac.telescope'.buffers()<CR>
nnoremap <Leader>f <cmd>lua require'zac.telescope'.find_in_current_folder()<CR>
nnoremap <Leader>v <cmd>lua require'zac.telescope'.search_dotfiles()<CR>
" nnoremap <C-p> <cmd>lua require'telescope.builtin'.live_grep{}<CR>
nnoremap <Leader>p <cmd>lua require'telescope.builtin'.live_grep()<CR>
tnoremap <Esc> <C-\><C-n>


" NERDTree config
noremap <Leader>t :NERDTreeToggle<CR>
noremap <Leader>e :NERDTreeFind<CR>

" nnoremap <Leader>vi :e $MYVIMRC<CR> 
nnoremap <Leader>r :source $MYVIMRC<CR> 

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


let g:easyescape_chars = { "h": 2 }
let g:easyescape_timeout = 100




let g:indent_blankline_char_list = ['|', '¦', '┆', '┊']

nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> E <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>




inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })


highlight TelescopeMatching       guifg=#E79921

