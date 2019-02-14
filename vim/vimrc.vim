set nocompatible
execute pathogen#infect('bundle/{}','~/dotfiles/vim/bundle/{}')
let mapleader=","
filetype off
syntax on
set backspace=indent,eol,start
set number
set tabstop=4
set softtabstop=4
set shiftwidth=4
set pastetoggle=<F2>
set wildmenu
set showmatch
set incsearch
set hlsearch
set foldenable
set foldlevelstart=10
set foldmethod=marker
nnoremap <space> za
nnoremap j gj
nnoremap k gk
" Uncomment these to turn off arrow keys to practice hjkl movement
" map <UP> <NOP>
" map <LEFT> <NOP>
" map <DOWN> <NOP>
" map <RIGHT> <NOP>
filetype plugin indent on
syntax on
set background=dark
colorscheme gruvbox
let g:gruvbox_vert_split = 'bg1'
let g:gruvbox_sign_column = 'bg0'
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }
set laststatus=2
