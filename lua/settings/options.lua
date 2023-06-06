vim.cmd(
  [[
" syntax on                   " 开启语法高亮功能 允许用指定语法高亮配色方案替换默认方案
" filetype plugin indent on   " 为特定文件类型载入相应缩进配置
" filetype on                 " 为特定文件类型载入相应文件类型插件
set showmatch               " 显示匹配括号
" set autochdir               " 自动切换当前目录为当前文件所在的目录  
set autowrite               " 自动保存
" set confirm                 " 在处理未保存或只读文件的时候，弹出确认
set nobackup                " 从不备份  
set noswapfile              " 禁止生成临时文件
set undofile                " vim退出并在下次打开后仍然保留上次的undo历史
set undolevels=1000         " max number of undos
set undoreload=10000        " max lines to to save for undo

set shortmess=atI           " 不显示进入提示 
set helplang=CN             " 中文帮助语言
set noerrorbells            " 无警告音
set novisualbell            " 无选中提示音
set t_vb=
" set relativenumber

"""""""行"""""""
set nu                      " 显示行号
" set nowrap                  " 不折行
set cursorline              " 高亮当前行
set cmdheight=1             " 命令行（在状态行下）的高度，设置为1  
set scrolloff=3             " 光标移动到buffer的顶部和底部时保持3行距离  

"""""""搜索"""""""
set wrapscan                " 搜索到文件两端时不重新搜索  
set ignorecase              " 搜索忽略大小写
set iskeyword+=_,$,@,%,#,-  " 带有如下符号的单词不要被换行分割
set matchtime=1             " 光标高亮时间

"""""""空格缩进及折叠"""""""
set foldenable              " 允许折叠  
set foldmethod=manual       " 手动折叠 
set expandtab               " 空格代替tab
set softtabstop=2           " 设定tab长度为2  
set shiftwidth=2            " 设定 << 和 >> 命令移动时的宽度为 2  
set smartindent             " 智能对齐

"""""""鼠标和光标"""""""
" set mouse=a                 " 鼠标可定位
" set selection=exclusive
" set selectmode=mouse,key
" set gcr=a:block-blinkon0    " 禁止光标闪烁
" set guicursor=n-v-c:block-Cursor/lCursor,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175

"""""""""""
" set clipboard+=unnamedplus  " 始终使用系统剪切板
set wildmode=list:longest,full


if has('nvim')
  " 允许真彩显示
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
  " 允许光标变化
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
endif

set t_Co=256
" set autochdir

let g:python_host_prog  = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/bin/python3'


silent! so .vimlocal

set guifont=Inconsolata_Nerd_Font:h12
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

autocmd BufNewFile,BufRead *.wxml set filetype=html
autocmd BufNewFile,BufRead *.wxss set filetype=css

]]
)

vim.o.updatetime = 250
vim.g.laststatus = 3

-- use new filetype checker, which should be faster
-- vim.g.do_filetype_lua = 1
-- vim.g.did_load_filetypes = 0
-- vim.o.nofoldenable = true
