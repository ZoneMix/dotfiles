set nocompatible
set number
set relativenumber
set tabstop=4
set softtabstop=4
set pastetoggle=<F2>
set cursorline
set wildmenu
set showmatch
set incsearch
set hlsearch
set foldenable
set foldlevelstart=10
nnoremap <space> za
map <C-n> :NERDTreeToggle<CR>
set foldmethod=indent

filetype off
syntax off
set rtp+=~/dotfiles/vim/bundle/Vundle.vim
let path='~/dotfiles/vim/bundle'
call vundle#begin(path)

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'valloric/youcompleteme'
Plugin 'mattn/emmet-vim'
Plugin 'w0rp/ale'
Plugin 'majutsushi/tagbar'
Plugin 'junegunn/fzf'
Plugin 'tpope/vim-surround'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'flazz/vim-colorschemes'

call vundle#end()
colorscheme tomorrow-night

set showmode

autocmd ColorScheme *
	\ highlight User1 ctermfg=222 ctermbg=240 cterm=bold |
	\ highlight User2 ctermfg=246 ctermbg=240 cterm=none
set laststatus=2
set statusline=
set statusline+=\ ››
set statusline+=\ ~/%{expand('%:p:h')[strlen(expand('~'))+1:]}/
set statusline+=%1*%f%{&mod?'*':'\ '}\ 
set statusline+=%2*%y
set statusline+=%0*%=
set statusline+=\ %2l:%-2c
set statusline+=\ ‹‹\ 

filetype plugin indent on
syntax on
