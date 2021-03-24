set number
set title
set ruler

"execute pathogen#infect()
"syntax on
"filetype plugin indent on

nnoremap j gj
nnoremap k gk
let maplocalleader=","
"set smartindent
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set indentexpr=
inoremap jj <ESC>
inoremap kk <ESC>
set incsearch
set fileencoding=utf-8
set encoding=utf-8
noremap N <C-e>
noremap P <C-y>
noremap gh 0
noremap gl $
noremap ; :
inoremap <C-l> <Right>
"inoremap <C-k> <ESC><S-a><CR>
inoremap <C-k> <ESC><S-a><ESC>:call InsertEndSymbol()<CR><S-a><CR>
set noswapfile
set diffopt+=vertical

"<C-k>改行時に行末に;をつけるファイルの拡張子
let g:endsWithSemiColon = ["c", "cpp", "h", "hpp", "java", "rs"]
function InsertEndSymbol()
    let l:bufFileExt = expand("%:e")
    if(index(g:endsWithSemiColon, l:bufFileExt) >= 0)
        execute "normal a;"
    endif
endfunction

"前回のカーソル位置に移動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

"clipboard有効化
set clipboard=unnamedplus

"vim-plug settings
if has('vim_starting')
  set rtp+=~/.vim/plugged/vim-plug
  if !isdirectory(expand('~/.vim/plugged/vim-plug'))
    echo 'install vim-plug...'
    call system('mkdir -p ~/.vim/plugged/vim-plug')
    call system('git clone https://github.com/junegunn/vim-plug.git ~/.vim/plugged/vim-plug/autoload')
  end
endif

call plug#begin('~/.vim/plugged')
  "Vim Plug
  Plug 'junegunn/vim-plug',
        \ {'dir': '~/.vim/plugged/vim-plug/autoload'}
  "Auto Pair
  Plug 'jiangmiao/auto-pairs'
  "Emmet
  Plug 'mattn/emmet-vim'
  "Fish
  Plug 'dag/vim-fish'
  "Idris2
  Plug 'edwinb/idris2-vim'
  "Git
  Plug 'tpope/vim-fugitive'
  "Dhall
call plug#end()

"auto pair settings
autocmd BufReadPost *.cl let b:AutoPairs = {'(':')', '[':']', '{':'}','"':'"', '`':'`'}

augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.nim  setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.js   setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.rb   setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.html setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.hs   setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.idr  setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.purs setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.purs setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.elm  setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.y    setlocal tabstop=8 softtabstop=8 shiftwidth=8
    autocmd BufNewFile,BufRead *.c    setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.ros  setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.lisp setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.cbl  setlocal tabstop=7 softtabstop=7 shiftwidth=7
    autocmd BufNewFile,BufRead *.yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.egi setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.purs setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

function s:insertTemplate(name)
    let filename = "/home/main/.vim/template/" . a:name . ".txt"
    let lines = []
    for line in readfile(filename)
        call add(lines, line)
    endfor
    call append('.', lines)
endfunction
command! -nargs=1 It call s:insertTemplate(<f-args>)
