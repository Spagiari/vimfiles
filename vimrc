set nocompatible " Be iMproved

set number
set wrap
set backspace=indent,eol,start
set tabstop=4
set showcmd   " Show incomplete cmds down the bottom
set showmode  " Show current mode down the bottom
set incsearch " Find the next match as we type the search
set hlsearch  " Hilight searches by default
set magic " Set magic on, for regular expressions
set wildmode=list:longest " Make cmdline tab completion similar to bash
set ignorecase
set smartcase
set ruler
set history=1000
set backup

set ff=unix
set encoding=utf-8
set fileencoding=utf-8

" No sound, no blink on errros
set noerrorbells
set novisualbell

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

let file = expand("~/.vim/bundles.vim")
if filereadable(file)
  silent! execute 'source '.file
endif

try
  colorscheme base16-monokai
catch
endtry

filetype plugin indent on

" Window navigation
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Tab navigation
map <C-Tab> :tabnext<CR>
map <S-Tab> :tabprevious<CR>

" Highlight whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Automatically removing all trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

" NERDTree
" Open up a NERDtree at startup if there are no files provided
autocmd vimenter * if !argc() | NERDTree | endif
" Close Vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" GitGutter

if has('gui_running')
  " gVim settings
  set guioptions-=T     " Remove the toolbar
  set lines=40          " 40 lines of text instead of 24,
endif

" Status line
set statusline=[%04l,%04v]\ [A=\%03.3b\ H=\%02.2B]\ [%{&ff}-%Y]\ [LIN=%L]\ %<%F%h%r%h%w%m

" Auto reload vimrc
autocmd BufWritePost .vimrc source %

" Use local vimrc if available
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

