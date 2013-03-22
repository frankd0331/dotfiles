" Ok this vimrc file is almost more of a journal while I'm learning Vim
set nocompatible

" Current Plugins
" pathogen 				git://github.com/tpope/vim-pathogen.git
" solarized				git://github.com/altercation/vim-colors-solarized.git
" tComment				git://github.com/vim-scripts/tComment.git
" easy motion			git://github.com/Lokaltog/vim-easymotion.git
"
" Considerd Plugins
" snipmate

" This sets a new blank editor to $HOME or
" This sets :pwd to current file's directory
cd $HOME
set autochdir

runtime bundle/vim-pathogen/autoload/pathogen.vim
" it looks like the above is good enough for both windows and linux
" i thought the below would be needed for linux but it doesn't seem to matter
" i'm thinking because where-ever bundle is, it is already apart of the
" runtime
" runtime ~/.vim/bundle/vim-pathogen/autoload/pathogen.vim

" Pathogen -- ok I don't think I'm gonna use this now
" still here as a reminder though
" nevermind gonna use it
" https://github.com/tpope/vim-pathogen 
execute pathogen#infect('bundle/{}')
filetype plugin indent on


" This shows numbers of lines
set number

" I think syntax on is default already, but I want it regardless of system
syntax enable

" Here I'm trying out solarize for Vim because it looks more mature than monokai
" https://github.com/altercation/vim-colors-solarized
set background=dark
" Apparently I need to set the g:solarized_italic variable to 0 before I
" set color scheme to solarized
let g:solarized_italic=0
colorscheme solarized
call togglebg#map("")


" Ubuntu_Mono set to 14
" trying to check os first
if has("gui_running")
	" Setting the default window size
	set lines=50 columns=100
	if has("gui_win32")
		set guifont=Ubuntu_Mono:h12:cANSI
		nmap _t :!cmd<CR>
	elseif has("gui_gtk2")
		set guifont=Ubuntu\ Mono\ 12
	endif
endif

" Use CTRL-s for saving, also in Insert mode
" I think use in terminal will require more effort
" http://vim.wikia.com/wiki/Map_Ctrl-S_to_save_current_or_new_files
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>

" Quick note! I need to learn git and use them for manageing updates on some
" of this stuff

" Some Behaviour changes
set tabstop=4
set autoindent
set copyindent	
set shiftwidth=4

set showmatch	" shows matching parens
set smarttab
set ignorecase
set hlsearch
set incsearch	" shows search matches as you type

set nobackup
set noswapfile

set guioptions-=T	" remove toolbar

set foldmethod=syntax
set nofoldenable

set fileencoding=utf-8
set encoding=utf-8

set backspace=indent,eol,start

set visualbell

set cursorline

set nolist 
set listchars=tab:»·,trail:·,eol:¬

" Word wrap without line breaks
set wrap
set linebreak
set nolist	" list disables linebreak
set textwidth=0
set wrapmargin=0
