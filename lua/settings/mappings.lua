local map = vim.keymap.set

vim.cmd(
  [[

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
" colorscheme minimal-base16
" colorscheme aurora
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

nnoremap <Leader>d :DiffviewOpen<CR>


" close other tabs
nnoremap <Leader>c :tabonly<CR>

nnoremap <leader>S :lua require('spectre').open()<CR>

nnoremap <Leader>v <cmd>lua require'zac.telescope'.search_dotfiles()<CR>
nnoremap <Leader>l <cmd>lua vim.lsp.buf.format()<CR>
" nnoremap <C-p> <cmd>lua require'telescope.builtin'.live_grep{}<CR>
nnoremap <Leader>p <cmd>lua require'zac.telescope'.grep_find()<CR>
" nnoremap f <cmd>lua require'hop'.hint_words()<CR>
" nnoremap <leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
" nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
tnoremap <Esc> <C-\><C-n>


" NERDTree config
" Git 相关的命令
" noremap <Leader>t :Neotree reveal=true toggle<CR>
" noremap <Leader>e :Neotree reveal=true toggle<CR>
" command! G :LazyGitCurrentFile
command! Gw :Gitsigns stage_buffer
command! Gr :Gitsigns reset_buffer
command! Gd :Gitsigns diffthis
command! Format :lua vim.lsp.buf.format()
" command! Gcommit Neogit<space>commit


" nnoremap <Leader>vi :e $MYVIMRC<CR> 
nnoremap <Leader>r <cmd>lua dotfile(vim.env.MYVIMRC)<CR> 

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

" nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
" nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
" nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent> E <cmd>lua vim..diagnostic.show_line_diagnostics()<CR>
" nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>


" inoremap <silent><expr> <C-Space> compe#complete()
" inoremap <silent><expr> <CR>      compe#confirm({ 'keys': '<CR>', 'select': v:true })
" inoremap <silent><expr> <C-e>     compe#close('<C-e>')
" inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
" inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'



" autocmd BufWritePre *.go,*.rb lua vim.lsp.buf.formatting()
" autocmd BufWritePre *.vue PrettierAsync()
" autocmd BufWritePre *.js PrettierAsync()

" autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | OSCYankReg " | endif
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

" au BufWritePost ~/.config/nvim/*.{vim,lua} so $MYVIMRC
"
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'


let g:ctrlsf_default_root = 'project'

" command! Gcommit Neogit<space>commit

" autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting_sync()

" command! Firework lua require("../zac/firework").expand()

" nnoremap <silent> <leader>z :<c-u>lua require('../zac/firework').expand("n")<CR>
" xnoremap <silent> <leader>z :<c-u>lua require("../zac/firework").expand("v")<CR>
" autocmd User PackerCompileDone echom "compile finish"
]]
)
map("n", "<Leader>s", "<Plug>CtrlSFCwordExec")

map(
  { "n", "v" },
  "<Enter>",
  function()
    require("../zac/firework").expand()
  end,
  {
    desc = "to run firework"
  }
)

-- map('n', '<leader>c', require('osc52').copy_operator, {expr = true})
-- map('x', '<leader>c', require('osc52').copy_visual)
-- autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | OSCYankReg " | endif
vim.keymap.set("n", "<leader>e", require("oil").open, {desc = "Open Oil directory"})
