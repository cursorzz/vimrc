set bg=dark                 " 暗色主题
" colorscheme Tomorrow-Night-Eighties         " 颜色主题
" colorscheme palenight
" colorscheme lunar
" colorscheme iceberg
set termguicolors
let g:tokyonight_style = "night"
let g:tokyonight_dark_sidebar = "true"
" colorscheme gruvbox
colorscheme tokyonight
" colorscheme iceberg
" colorscheme base16-schemer-dark

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

" universal yank 
vnoremap <leader>c :OSCYank<CR>
autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | OSCYankReg " | endif


nnoremap <Leader>d :DiffviewOpen<CR>


" close other tabs
nnoremap <Leader>c :tabonly<CR>

nnoremap <leader>S :lua require('spectre').open()<CR>

nnoremap <C-f> <cmd>lua require'zac.telescope'.git_files()<CR>
nnoremap <C-g> <cmd>lua require'zac.telescope'.find_in_current_folder()<CR>
nnoremap <C-b> <cmd>lua require'zac.telescope'.buffers()<CR>
nnoremap <Leader>v <cmd>lua require'zac.telescope'.search_dotfiles()<CR>
nnoremap <Leader>l <cmd>lua vim.lsp.buf.formatting()<CR>
" nnoremap <C-p> <cmd>lua require'telescope.builtin'.live_grep{}<CR>
nnoremap <Leader>p <cmd>lua require'zac.telescope'.grep_find()<CR>
nnoremap f <cmd>lua require'hop'.hint_words()<CR>
" nnoremap <leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
" nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
tnoremap <Esc> <C-\><C-n>


" NERDTree config
noremap <Leader>t :NvimTreeToggle<CR>
noremap <Leader>e :NvimTreeFindFile<CR>

" nnoremap <Leader>vi :e $MYVIMRC<CR> 
nnoremap <Leader>r :source $MYVIMRC<CR> 

" function! ToggleNerdTree() abort
"   let isOpen = get(g:, 'NERDTree.IsOpen', 0)
"   echom isOpen
"   if isOpen == 0
"     :NERDTreeToggle
"     :NERDTreeFind
"   else
"     :NERDTreeToggle
"   endif
" endfunction


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

imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'



autocmd BufWritePre *.go,*.rb lua vim.lsp.buf.formatting()
" autocmd BufWritePre *.vue PrettierAsync()
" autocmd BufWritePre *.js PrettierAsync()

autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | OSCYankReg " | endif
let g:prettier#autoformat_require_pragma = 0

if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
autocmd InsertEnter * set cul
autocmd InsertLeave * set nocul

highlight TelescopeMatching       guifg=#E79921
