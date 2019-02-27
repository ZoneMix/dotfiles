set nocompatible
let mapleader=","
filetype off

set rtp+=~/dotfiles/vim/bundle/Vundle.vim
call vundle#begin('~/dotfiles/vim/bundle')

Plugin 'mattn/emmet-vim'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'morhetz/gruvbox'
Plugin 'itchyny/lightline.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-surround'
Plugin 'Valloric/YouCompleteMe'
Plugin 'davidhalter/jedi-vim'
Plugin 'w0rp/ale'
Plugin 'wincent/terminus'

call vundle#end()

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
map <leader>at :ALEToggle<CR>
inoremap <leader>for <esc>Ifor (int i = 0; i < <esc>A; i++){<enter><BS>}<esc>O
inoremap <leader>2for <esc>Ifor (int j = 0; j < <esc>A; j++){<enter><BS>}<esc>O
inoremap <leader>3for <esc>Ifor (int k = 0; k < <esc>A; k++){<enter><BS>}<esc>O
inoremap <leader>4for <esc>Ifor (int l = 0; l < <esc>A; l++){<enter><BS>}<esc>O
" Uncomment these to turn off arrow keys to practice hjkl movement
" map <UP> <NOP>
" map <LEFT> <NOP>
" map <DOWN> <NOP>
" map <RIGHT> <NOP>
filetype plugin indent on
syntax on
set background=dark
colorscheme gruvbox
set completeopt-=preview
let g:ycm_confirm_extra_conf = 0
let g:ycm_filetype_blacklist = { 'python': 1 }
let g:jedi#force_py_version = 3
let g:jedi#show_call_signatures = "0"
let g:pymode_rope = 0
let g:gruvbox_vert_split = 'bg1'
let g:gruvbox_sign_column = 'bg0'
let g:gruvbox_invert_selection = 0
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }
set laststatus=2
let g:ale_linters = {
	  \ 'cpp': ['gcc']
	  \ }
let g:ale_cpp_gcc_options = '-std=c++17 -Wall'
let g:ycm_show_diagnostics_ui = 0
" hi Visual ctermfg=255 guifg=#FFFFFF ctermbg=93 guibg=#8700ff
au BufRead,BufNewFile *.asm set filetype=nasm
