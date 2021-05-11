func Eatchar(pat)
   let c = nr2char(getchar(0))
   return (c =~ a:pat) ? '' : c
 endfunc  

ia ci ``<Left><C-R>=Eatchar('\s')<CR>
ia cb ```<cr>```<esc>k$A<C-R>=Eatchar('\s')<CR>

