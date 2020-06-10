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
filetype plugin on
filetype plugin indent on

syntax on

if empty(glob('~/.vim/autoload/plug.vim'))
	    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
			        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
			          autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" XML formatter
com! FormatXML :%!python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"
nnoremap = :FormatXML<Cr>
" JSON formatter
com! FormatJSON :%!python3 -m json.tool 
nnoremap = :FormatJSON<Cr>

call plug#begin('~/.vim/plugged')
	Plug 'vim-scripts/XML-Completion'
	Plug 'junegunn/vim-plug'

	"{{ Configuring NerdTree
 	Plug 'scrooloose/nerdtree'
	" ---> to hide unwanted files <---
	let NERDTreeIgnore = [ '__pycache__', '\.pyc$', '\.o$', '\.swp',  '*\.swp',  'node_modules/' ]
	" ---> show hidden files <---
	let NERDTreeShowHidden=1
	" ---> hide on open <---
	let NERDTreeQuitOnOpen = 1
	" ---> autostart nerd-tree when you start vim <---
	" ---> hide ? info <--- "
	let NERDTreeMinimalUI = 1
	"autocmd vimenter * NERDTree"
	autocmd StdinReadPre * let s:std_in=1
	autocmd VimEnter * if argc() == 0 && !exists("s:stdn_in") | NERDTree | endif
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
	" ---> toggling nerd-tree using Ctrl-N <---
	map <C-n> :NERDTreeToggle<CR>
	"}}

	"{{ Configuring YouCompleteMe
	Plug 'valloric/youcompleteme', { 'do': './install.py' }
  
	" ---> youcompleteme configuration <---
	let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
  
  " ---> compatibility with another plugin (ultisnips) <---
  let g:ycm_key_list_select_completion = [ '<C-n>', '<Down>' ] 
	let g:ycm_key_list_previous_completion = [ '<C-p>', '<Up>' ]
	let g:SuperTabDefaultCompletionType = '<C-n>'
	"---> disable preview window <---"
	set completeopt-=preview
	" ---> navigating to the definition of a a symbol <---
	map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
	"}}

	"{{ Configuring CtrlP
	Plug 'ctrlpvim/ctrlp.vim'
	let g:ctrlp_max_files = 0
	let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
	set wildignore+=*/node_modules/**
	"}}

	"{{ Configuring UltiSnips
	Plug 'SirVer/ultisnips'
	Plug 'honza/vim-snippets'
	let g:UltiSnipsExpandTrigger = "<tab>"
	let g:UltiSnipsJumpForwardTrigger = "<tab>"
	let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
	"}}

	"{{ Git integration
	" ---> git commands within vim <---
	Plug 'tpope/vim-fugitive'
	" ---> git changes on the gutter <---
	Plug 'airblade/vim-gitgutter'
	" ---> nerdtree git changes <---
	Plug 'Xuyuanp/nerdtree-git-plugin'
	"}}

	"{{ Color-scheme
	Plug 'morhetz/gruvbox'
	set background=dark
	colorscheme gruvbox
	let g:gruvbox_contrast_dark='default'
	"}}

	"{{ Autopairs
	" ---> closing XML tags <---
	Plug 'alvan/vim-closetag'
	" ---> files on which to activate tags auto-closing <---
	"let g:closetag_filenames = '*.html,*.xhtml,*.xml,*.vue,*.phtml,*.js,*.jsx,*.coffee,*.erb'
	" ---> closing braces and brackets <---
	"Plug 'jiangmiao/auto-pairs'
	"}}

	"{{ TMux - Vim integration
	Plug 'christoomey/vim-tmux-navigator'
	"}}

	"{{ TMux - Vim integration
  Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
	"}}
	
	"{{ Typescript support 
  Plug 'leafgarland/typescript-vim'
	"}}

	"{{ Code formatting - web - post install (yarn install | npm install) then load plugin only for
	" editing supported files
	Plug 'prettier/vim-prettier', {
	   \ 'do': 'npm install -g',
	   \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json',
		 \				 'graphql', 'markdown', 'vue', 'yaml', 'html'] 
	   \ }
	let g:prettier#config#config_precedence = 'file-override'
	autocmd FileType typescript setlocal formatprg=prettier\ --parser\ typescript	
	"}}
	
	"{{ Linting 
	Plug 'dense-analysis/ale'

	let g:ale_linters = {
				\   'javascript': ['eslint'],
				\   'typescript': ['tsserver', 'tslint'],
				\   'vue': ['eslint']
				\}

	let g:ale_fixers = {
				\    'javascript': ['eslint'],
				\    'typescript': ['prettier'],
				\    'vue': ['eslint'],
				\    'scss': ['prettier'],
				\    'html': ['prettier']
				\}
	let g:ale_fix_on_save = 1
	"}}
call plug#end()
