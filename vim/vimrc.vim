set nocompatible
set number
set relativenumber
set tabstop=4
set softtabstop=4
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
colorscheme darkocean
filetype plugin indent on
syntax on
