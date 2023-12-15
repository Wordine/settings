call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'joom/vim-commentary'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'tracyone/fzf-funky',{'on': 'FzfFunky'}
Plug 'honza/vim-snippets'
Plug 'junegunn/fzf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'preservim/tagbar' " C-u
Plug 'jlanzarotta/bufexplorer'
call plug#end()
let mapleader = ";"    " 比较习惯用;作为命令前缀，右手小拇指直接能按到

set nocompatible    " 关闭兼容模式
syntax on           " 语法高亮
set re=0
set redrawtime=10000
filetype plugin on  " 文件类型插件
filetype indent on
set shortmess=atI   " 去掉欢迎界面
set autoindent
autocmd BufEnter * :syntax sync fromstart
set nu              " 显示行号
set showcmd         " 显示命令
set lz              " 当运行宏时，在命令执行完成之前，不重绘屏幕
set hid             " 可以在没有保存的情况下切换buffer
set backspace=eol,start,indent 
set whichwrap+=<,>,h,l " 退格键和方向键可以换行
set incsearch       " 增量式搜索
set nohlsearch
set title

noremap <leader>T :! ctags -f ~/.vim/tags -R /local/gsnws/sgsn_mme<CR>
set tags=~/.vim/tags

set ignorecase      " 搜索时忽略大小写
set magic           " 额，自己:h magic吧，一行很难解释
set showmatch       " 显示匹配的括号
set nobackup        " 关闭备份
set nowb
set noswapfile      " 不使用swp文件，注意，错误退出后无法恢复
set lbr             " 在breakat字符处而不是最后一个字符处断行
set ai              " 自动缩进
set si              " 智能缩进
set cindent         " C/C++风格缩进
set wildmenu         
set nofen
set fdl=10

set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

set mouse=n
set autoread

set background=dark
set t_Co=256
colorscheme desert

set encoding=utf8
set fileencodings=utf8,gb2312,gb18030,ucs-bom,latin1

set laststatus=2      " 总是显示状态栏
highlight StatusLine cterm=bold ctermfg=yellow ctermbg=blue

" Shift-Backspace to delete a word
inoremap <S-BS> <C-w>

function! CurDir()
    let curdir = substitute(getcwd(), $HOME, "~", "g")
    return curdir
endfunction
set statusline=[%n]\ %f%m%r%h\ \|\ \ pwd:\ %{CurDir()}\ \ \|%=\|\ %l,%c\ %p%%\ \|\ ascii=%b,hex=%b%{((&fenc==\"\")?\"\":\"\ \|\ \".&fenc)}\ \|\ %{$USER}\ @\ %{hostname()}\ 

function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"
    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")
    if a:direction == 'b'
        execute "normal ?" . l:pattern . "<cr>"
    else
        execute "normal /" . l:pattern . "<cr>"
    endif
    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" 用 */# 向 前/后 搜索光标下的单词
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

"从系统剪切板中复制，剪切，粘贴
noremap <leader>y "+y
noremap <leader>x "+x
noremap <leader>p "+p
set clipboard=unnamedplus,unnamed

" 恢复上次文件打开位置
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

set viminfo='1000,f1,<500
set clipboard=exclude:.*

" Leader
" map <silent> <leader>ss :source ~/.vimrc<cr>
" Quick Fix 设置
map <F3> :cw<cr>
map <F4> :cp<cr>
map <F5> :cn<cr>

set cursorcolumn
set cursorline

set foldmethod=indent

nnoremap <space> za

vnoremap <space> zf
" line replace
noremap <leader>r @r
" NERD Tree
map <leader>n :NERDTreeToggle<CR>
noremap <leader>t :NERDTreeFind<CR>
set noshowmode
" fzf find file
nnoremap <leader>p :Files /local/gsnws/sgsn_mme<CR>
nnoremap <c-g> :Ag<CR>
" easymotion
nmap ss <Plug>(easymotion-s2)
" Tagbar
nmap <leader>u :TagbarToggle<CR>
" lightline
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ]
      \ },
      \ 'tabline': {
      \   'left': [ ['buffers'] ],
      \   'right': [ ['close'] ]
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ }
      \ }

" bufferline
set showtabline=2
let g:lightline#bufferline#enable_devicons = 1
let g:lightline#bufferline#enable_nerdfont = 1
let g:lightline#bufferline#icon_position = 'right'
let g:lightline#bufferline#show_number = 3
let g:lightline#bufferline#filename_modifier = ':t'

let g:lightline#bufferline#number_map = {
\ 0: '⁰', 1: '¹ ', 2: '² ', 3: '³ ', 4: '⁴ ',
\ 5: '⁵', 6: '⁶', 7: '⁷', 8: '⁸', 9: '⁹'}

function LightlineBufferlineFilter(buffer)
  return getbufvar(a:buffer, '&buftype') !=# 'terminal'
endfunction
let g:lightline#bufferline#buffer_filter = "LightlineBufferlineFilter"

" buffer
noremap <leader>q :q<CR>
noremap <leader>w :w<CR>
noremap <leader>e :e<CR>G
nmap <S-Tab> :bprev<Return>
nmap <Tab> :bnext<Return>

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)
