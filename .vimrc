set nocompatible
filetype on
filetype plugin on
filetype indent on
syntax on

set belloff=all

set autoindent

set notimeout
set ttimeout
set ttimeoutlen=50

let &fillchars ..= ',eob: '

" line numbers
set number
set relativenumber

" highlight current line
set cursorline
set scrolloff=4
set wrap
let &showbreak = '⮡ '
set linebreak
set breakindent

" don't add newline to end of file
set nofixeol

" Searching
set incsearch
set ignorecase
set smartcase

" tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" custom binds
let mapleader=" "
nmap <leader>y "+y
nmap <leader>p "+p
nmap <leader>Y "+P
nmap <leader>P "+P
nmap <leader>d "_d
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz
vmap <leader>y "+y
vmap <leader>p "+p
vmap <leader>Y "+P
vmap <leader>P "+P
vmap <leader>d "_d
vnoremap <C-u> <C-u>zz
vnoremap <C-d> <C-d>zz

" status indicators
set showcmd
set laststatus=3

" visual whitespace characters
set list
set listchars=tab:→\ ,trail:·

" colors
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
colorscheme catppuccin_mocha

" colorcolumn
set colorcolumn=80
hi! link ColorColumn CursorLine
