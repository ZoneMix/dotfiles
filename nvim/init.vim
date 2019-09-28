" {{{ Plugins
	call plug#begin('~/dotfiles/nvim/plugins')

	Plug 'neomake/neomake'
	Plug 'Shougo/deoplete.nvim'
	Plug 'Shougo/deoplete-clangx'
	Plug 'deoplete-plugins/deoplete-jedi'
	Plug 'sebastianmarkow/deoplete-rust'
	Plug 'HerringtonDarkholme/yats.vim'
	Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
	Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
	Plug 'donRaphaco/neotex', { 'for': 'tex' }
	Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh \| UpdateRemotePlugins' }
	Plug 'edkolev/tmuxline.vim'
	Plug 'vim-airline/vim-airline'
	Plug 'tyrannicaltoucan/vim-quantum'
	Plug 'scrooloose/nerdtree'
	Plug 'scrooloose/nerdcommenter'
	Plug 'tpope/vim-surround'
	Plug 'beyondmarc/glsl.vim'
	Plug 'terryma/vim-multiple-cursors'
	Plug 'AndrewRadev/sideways.vim'
	Plug 'AndrewRadev/splitjoin.vim'
	Plug 'ctrlpvim/ctrlp.vim'
	Plug 'xolox/vim-misc'
	Plug 'xolox/vim-notes'

	call plug#end()
" }}}
" {{{ builtins
	set number
	let mapleader = "\<Space>"
	syntax on
	filetype plugin indent on
	set backspace=indent,eol,start
	set tabstop=4
	set softtabstop=4
	set shiftwidth=4
	set pastetoggle=<F2>
	set wildmenu
	set showmatch
	set incsearch
	set hlsearch
	set foldenable
	"This will Fold everything
	"set foldlevelstart=0
	set foldlevelstart=20
	set foldmethod=marker
" }}}
" {{{ remaps
	nnoremap <leader>f za

	nnoremap <C-j> :tabn<cr>
	nnoremap <C-k> :tabp<cr>

	nnoremap <C-t> :NERDTreeToggle<enter>
	inoremap <C-t> :NERDTreeToggle<enter>

	nnoremap <C-h> :SidewaysLeft<cr>
	nnoremap <C-l> :SidewaysRight<cr>

" }}}
" {{{ neomake
	call neomake#configure#automake('nrwi', 1)
	let g:neomake_warning_sign = {
	  \ 'text': '--',
	  \ 'texthl': 'WarningMsg',
	  \ }
	let g:neomake_error_sign = {
	  \ 'text': '>>',
	  \ 'texthl': 'ErrorMsg',
	  \ }
" }}}
" {{{ deoplete
	let g:deoplete#enable_at_startup = 1
	" call deoplete#custom#var('clangx', 'default_c_options', '')
	" call deoplete#custom#var('clangx', 'default_cpp_options', '')
	let g:deoplete#sources#rust#racer_binary='/Users/blake/.cargo/bin/racer'
	let g:deoplete#sources#rust#rust_source_path='/Users/blake/.rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src'
	let g:deoplete#sources#ternjs#types = 1
" }}}
" {{{ neotex
	let g:neotex_delay = 1
" }}}
" {{{ quantum
	let g:quantum_black = 1
	let g:quantum_italics = 1
	set background=dark
	set termguicolors
	colorscheme quantum
" }}}
" {{{ airline
	let g:airline_powerline_fonts = 1
	let g:airline_theme = 'quantum'
	let g:airline_section_z = ' %p%% %l:%c '
" }}}
" {{{ vim-notes
	let g:notes_directories = ['~/class/Notes']
	let g:notes_suffix = '.txt'
" }}}
" {{{ tmuxline
	let g:tmuxline_preset = {
		\'a': '#S',
		\'b': '#h',
		\'c': '',
		\'win': '#I #W',
		\'cwin': '#I #W',
		\'x': '#(sh ~/dotfiles/scripts/cpu_percentage.sh)',
		\'y': '#(sh ~/dotfiles/scripts/batt.sh)',
		\'z': '#(date +"%l:%M%p")'}
" }}}
" {{{ autocmd
	autocmd BufRead,BufNewFile *.txt highlight notesTextURL ctermfg=39 guifg=#00afff gui=underline cterm=underline
	autocmd BufRead,BufNewFile *.txt highlight notesRealURL ctermfg=39 guifg=#00afff gui=underline cterm=underline
	autocmd BufRead,BufNewFile *.txt highlight notesEmailAddr ctermfg=39 guifg=#00afff gui=underline cterm=underline
	autocmd BufRead,BufNewFile *.txt highlight notesAtxHeading ctermfg=28 guifg=#008700 gui=bold cterm=bold
" }}}
" {{{ highlights
	hi Visual ctermfg=255 guifg=#FFFFFF ctermbg=129 guibg=#AF00FF
	highlight Comment cterm=italic
" }}}
" {{{ functions & commands
	command Skim :execute "!open -a Skim '" . split(@%,'\.')[0] . ".pdf'"
" }}}
