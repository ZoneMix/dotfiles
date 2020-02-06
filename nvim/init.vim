set nocompatible
" {{{ Plugins
	call plug#begin('~/dotfiles/nvim/plugins')

	Plug 'neomake/neomake'
	Plug 'Shougo/deoplete.nvim'
	Plug 'Shougo/deoplete-clangx'
	Plug 'donRaphaco/neotex', { 'for': 'tex' }
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
	Plug 'vimwiki/vimwiki'
	Plug 'mrk21/yaml-vim'
	Plug 'voldikss/vim-floaterm'
	Plug 'thaerkh/vim-indentguides'
	Plug 'jceb/vim-orgmode'

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
	set splitbelow
	set splitright
" }}}
" {{{ remaps
	nnoremap <leader>f za

	nnoremap <C-t> :NERDTreeToggle<cr>
	inoremap <C-t> :NERDTreeToggle<cr>

	nmap <C-S-Right> :tabn<cr>
	nmap <C-S-Left> :tabp<cr>
	nmap <leader>sl :SidewaysLeft<cr>
	nmap <leader>sr :SidewaysRight<cr>
	vmap <C-S-Right> :tabn<cr>
	vmap <C-S-Left> :tabp<cr>
	vmap <leader>sl :SidewaysLeft<cr>
	vmap <leader>sr :SidewaysRight<cr>
	"imap <C-S-Right> :tabn<cr>
	"imap <C-S-Left> :tabp<cr>
	"imap <leader>sl :SidewaysLeft<cr>
	"imap <leader>sr :SidewaysRight<cr>

	nnoremap <C-J> <C-W><C-J>
	nnoremap <C-K> <C-W><C-K>
	nnoremap <C-L> <C-W><C-L>
	nnoremap <C-H> <C-W><C-H>
	vnoremap <C-J> <C-W><C-J>
	vnoremap <C-K> <C-W><C-K>
	vnoremap <C-L> <C-W><C-L>
	vnoremap <C-H> <C-W><C-H>

	nmap <leader>bn :vnew<cr>
	nmap <leader>bN :enew<cr>
	nmap <leader>bh :new<cr>
	nmap <leader>bq :q<cr>
	nmap <leader>bk :q<cr>
	nmap <leader>bd :q<cr>
	nmap <leader>bQ :q!<cr>
	nmap <leader>bK :q!<cr>
	nmap <leader>bD :q!<cr>
	nmap <leader>bz :close<cr>
	nmap <leader>bb :buffers<cr>:buffer<Space>
	vmap <leader>bn :vnew<cr>
	vmap <leader>bN :enew<cr>
	vmap <leader>bh :new<cr>
	vmap <leader>bq :q<cr>
	vmap <leader>bk :q<cr>
	vmap <leader>bd :q<cr>
	vmap <leader>bQ :q!<cr>
	vmap <leader>bK :q!<cr>
	vmap <leader>bD :q!<cr>
	vmap <leader>bz :close<cr>
	vmap <leader>bb :buffers<cr>:buffer<Space>

	nmap <leader>wn :tabnew<cr>
	nmap <leader>wd :tabclose<cr>

	nmap <leader>igt :IndentGuidesToggle<cr>

	noremap <silent> <F12> :FloatermToggle<CR>i
	noremap! <silent> <F12> <Esc>:FloatermToggle<CR>i
	tnoremap <silent> <F12> <C-\><C-n>:FloatermToggle<CR>
" }}}
" {{{ functions & commands
	command Skim :execute "!open -a Skim '" . split(@%,'\.')[0] . ".pdf'"
	let s:previousMode=''
	let s:tmuxenv = $TMUX
	let s:tmux = 0
	if (s:tmuxenv != "")
		let s:tmux = 1
	endif
	function! ChangeTmuxline()
		if s:tmux == 1
			let currentMode=mode()
			if s:previousMode != currentMode
				if currentMode == "i" || currentMode == "ic" || currentMode == "ix" || currentMode == "R" || currentMode == "Rx" || currentMode == "Rc" || currentMode == "Rv"
					:Tmuxline airline_insert
				elseif currentMode == "n" || currentMode == "niR" || currentMode == "niI" || currentMode == "niV" || currentMode == "no" || currentMode == "nov" || currentMode == "noV" || currentMode == "noCTRL-V" || currentMode == "c" || currentMode == "ce" || currentMode == "cv" || currentMode == "r" || currentMode == "rm" || currentMode == "r?" || currentMode == "!" || currentMode == "t"
					:Tmuxline airline
				elseif currentMode == "v" || currentMode == "V" || currentMode == "CTRL-V" || currentMode == "s" || currentMode == "S" || currentMode == "CTRL-S"
					:Tmuxline airline_visual
				endif
				let s:previousMode=currentMode
			endif	
		endif
		return ""
	endfunction
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
	if !exists('g:airline_symbols')
		let g:airline_symbols = {}
	endif
	let g:airline_powerline_fonts = 1
	let g:airline_theme = 'quantum'
	let g:airline_section_z = '%{ChangeTmuxline()} %p%% %l:%c '

    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline_symbols.branch = ''
    let g:airline_symbols.readonly = ''
    let g:airline_symbols.linenr = ''
" }}}
" {{{ vim-notes
	let g:notes_directories = ['~/class/Notes']
	let g:notes_suffix = '.txt'
" }}}
" {{{ tmuxline
	let g:tmuxline_powerline_separators = 1
	let g:tmuxline_theme = 'airline'
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
" {{{ floaterm 
	let g:floaterm_position = 'center'
" }}}
" {{{ vim-indentguides 

" }}}
" {{{ autocmd
	autocmd BufRead,BufNewFile *.txt highlight notesTextURL ctermfg=39 guifg=#00afff gui=underline cterm=underline
	autocmd BufRead,BufNewFile *.txt highlight notesRealURL ctermfg=39 guifg=#00afff gui=underline cterm=underline
	autocmd BufRead,BufNewFile *.txt highlight notesEmailAddr ctermfg=39 guifg=#00afff gui=underline cterm=underline
	autocmd BufRead,BufNewFile *.txt highlight notesAtxHeading ctermfg=28 guifg=#008700 gui=bold cterm=bold

	autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

	au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
	autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
" }}}
" {{{ highlights
	hi Visual ctermfg=255 guifg=#FFFFFF ctermbg=129 guibg=#AF00FF
	highlight Comment cterm=italic
" }}}
