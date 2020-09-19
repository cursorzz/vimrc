" COC.vim related config and mappings
nnoremap <silent> <C-b> :<C-u>CocList files<CR>
nnoremap <silent> <C-f> :<C-u>CocList files -F<CR>
nnoremap <silent> <C-g> :<C-u>CocList buffers<CR>

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" coc-smartf plugin config press <esc> to cancel.
nmap f <Plug>(coc-smartf-forward)
nmap F <Plug>(coc-smartf-backward)
nmap ; <Plug>(coc-smartf-repeat)
nmap , <Plug>(coc-smartf-repeat-opposite)

augroup Smartf
  autocmd User SmartfEnter :hi Conceal ctermfg=220 guifg=#6638F0
  autocmd User SmartfLeave :hi Conceal ctermfg=239 guifg=#504945
augroup end

" NERDTree config
noremap <Leader>t :NERDTreeToggle<CR>
noremap <Leader>e :NERDTreeFind<CR>

" ctrfconfig
"
nmap     <C-p> <Plug>CtrlSFPrompt
vmap     <C-p> <Plug>CtrlSFVwordPath
let g:ctrlsf_default_root = 'project'
let g:ctrlsf_search_mode = 'async'

" lightline config
function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' '). ' ' . get(g:, 'coc_status', '')
endfunction

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus','gitbranch', 'currentfunction', 'message', 'readonly', 'modified', 'filepath' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'gitbranch': 'fugitive#head',
      \   'filepath': 'LightlineFilename',
      \   'abspath': '%F',
      \   'relativepath': '%f',
      \   'currentfunction': 'CocCurrentFunction',
      \   'message': 'StatusDiagnostic'
      \ },
      \ }


" sneak config
let g:sneak#label = 1

" easyescape
let g:easyescape_chars = { "h": 2 }
let g:easyescape_timeout = 100



command! -nargs=0 Prettier :CocCommand prettier.formatFile
