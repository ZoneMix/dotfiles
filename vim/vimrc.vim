"	VIMRC	"
"	General Vim Settings {{{
	set nocompatible
	let mapleader=","
	filetype off
	syntax on
	set number
	set relativenumber
	set tabstop=4
	set softtabstop=4
	set shiftwidth=4
	set pastetoggle=<F2>
	set cursorline
	set wildmenu
	set showmatch
	set incsearch
	set hlsearch
	set foldenable
	set foldlevelstart=10
	set foldmethod=marker
	set showmode
"	}}} 
"	Vim Mappings {{{
	nnoremap <space> za
	nnoremap <C-j> :m .+1<CR>==
	nnoremap <C-k> :m .-2<CR>==
	inoremap <C-j> <Esc>:m .+1<CR>==gi
	inoremap <C-k> <Esc>:m .-2<CR>==gi
	vnoremap <C-j> :m '>+1<CR>gv=gv
	vnoremap <C-k> :m '<-2<CR>gv=gv
	nnoremap <C-H> <C-W><C-H>
	nnoremap <C-J> <C-W><C-J>
	nnoremap <C-K> <C-W><C-K>
	nnoremap <C-L> <C-W><C-L>
	inoremap <C-H> <C-W><C-H>
	inoremap <C-J> <C-W><C-J>
	inoremap <C-K> <C-W><C-K>
	inoremap <C-L> <C-W><C-L>
	vnoremap <C-H> <C-W><C-H>
	vnoremap <C-J> <C-W><C-J>
	vnoremap <C-K> <C-W><C-K>
	vnoremap <C-L> <C-W><C-L>
	map <C-t> :NERDTreeToggle<CR>
	nmap <F8> :TagbarToggle<CR>
	inoremap <leader>for <esc>Ifor (int i = 0; i < <esc>A; i++){<enter><BS>}<esc>O
	inoremap <leader>vfor <esc>Ifor (<esc>lywhA.begin(); it != <esc>pa.end(); ++it){<enter><BS>}<esc>O<esc>k0lllllavector<>::iterator it = <esc>17ha
	"	C {{{
		inoremap <leader>out <esc>Iprintf(<esc>A);<esc>2hi
		vnoremap <leader>out yOprintf(, <esc>pA);<esc>h%a
	" }}}
	"	C++ {{{
		inoremap <leader>cout <esc>Icout << <esc>A << endl;
		vnoremap <leader>cout yOcout << <esc>pA << endl;
	" }}}
	"	Python {{{
		inoremap <leader>pp <esc>Iprint(<esc>A)
		vnoremap <leader>pp yOprint(<esc>pA)
	" }}}
	"	Javascript {{{
		inoremap <leader>con <esc>Iconsole.log(<esc>A);
		vnoremap <leader>con yOconsole.log(<esc>pA);
	" }}}
	"	Java {{{
		inoremap <leader>sys <esc>ISystem.out.println(<esc>A);
		vnoremap <leader>sys yOSystem.out.println(<esc>pA);
	" }}}
"	}}}
"	Vundle Plugins {{{
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
	filetype plugin indent on
	syntax on
"	}}}
"	Colorscheme and Statusbar {{{
colorscheme tomorrow-night

autocmd ColorScheme *
			\ highlight User1 ctermfg=222 ctermbg=240 cterm=bold |
			\ highlight User2 ctermfg=246 ctermbg=240 cterm=none
set laststatus=2
set statusline=
set statusline+=\ ››
set statusline+=\ %F%{&mod?'*':'\ '}\ 
set statusline+=%y
set statusline+=%=
set statusline+=\ %2l:%-2c
set statusline+=\ ‹‹\ 
"	}}}
