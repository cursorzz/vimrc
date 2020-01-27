" COC.vim related config and mappings
nnoremap <silent> <C-b> :<C-u>CocList files<CR>
nnoremap <silent> <C-f> :<C-u>CocList files -F<CR>
nnoremap <silent> <C-g> :<C-u>CocList buffers<CR>
nnoremap <silent> <C-p> :<C-u>Clap grep<CR>

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" NERDTree config
noremap <Leader>t :NERDTreeToggle<CR>
noremap <Leader>e :NERDTreeFind<CR>


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
