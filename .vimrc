" Tabs
:set shiftwidth=2
:set tabstop=2
:set softtabstop=2
:set autoindent
:set smartindent

" Searching
set hlsearch                            " highlight search terms
set incsearch                           " show search matches as you type
set ignorecase                          " ignore case when searching
set smartcase                           " make searches case sensitive only if they contain uppercase stuff

" Encoding
set encoding=utf-8                      " use utf-8 everywhere
set fileencoding=utf-8                  " use utf-8 everywhere
set termencoding=utf-8                  " use utf-8 everywhere


" History
set history=500                         " number of command lines stored in the history tables
set undolevels=500                      " number of levels of undo

" Misc
set number
filetype plugin indent on

syntax on

if empty(glob('~/.vim/autoload/plug.vim'))
	    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
			        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
			          autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
	Plug 'vim-scripts/XML-Completion'
	Plug 'junegunn/vim-plug'
call plug#end()
