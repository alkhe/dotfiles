" short circuit if evim
if v:progname =~? 'evim'
	finish
endif

" no vi compatibility
set nocp

" dein.vim

set rtp+=~/.vim/bundles/repos/github.com/Shougo/dein.vim
call dein#begin(expand('~/.vim'))

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim', { 'build': 'make' })
call dein#add('L9')

" autocomplete

call dein#add('Shougo/deoplete.nvim')

" readline insert mode

call dein#add('tpope/vim-rsi')

" faster navigation

call dein#add('easymotion/vim-easymotion')

" status bar

call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')

" git integration

call dein#add('airblade/vim-gitgutter')

" color schemes

call dein#add('joshdick/onedark.vim')
" call dein#add('raphamorim/lucario')
" call dein#add('dracula/vim')
" call dein#add('YorickPeterse/happy_hacking.vim')
" call dein#add('MvanDiemen/ghostbuster')
" call dein#add('rakr/vim-two-firewatch')
" call dein#add('tyrannicaltoucan/vim-deep-space')
" call dein#add('rakr/vim-one')

" syntax plugins

call dein#add('pangloss/vim-javascript')
call dein#add('mxw/vim-jsx')
call dein#add('justinmk/vim-syntax-extra')
" call dein#add('lambdatoast/elm.vim')
" call dein#add('eagletmt/ghcmod-vim', { 'on_ft': 'haskell' })
" call dein#add('eagletmt/neco-ghc', { 'on_ft': 'haskell' })
" call dein#add('rust-lang/rust.vim')
" call dein#add('zah/nim.vim')
" call dein#add('jordwalke/vim-reason-loader')
" call dein#add('facebook/reason', { 'rtp': 'editorSupport/VimReason' })

call dein#end()

" colors
set background=dark
colorscheme onedark
let g:airline_theme='hybrid'

" react syntax
let g:js_ext_required = 0

" sql fix Ctrl-C
let g:ftplugin_sql_omni_key = '<C-j>'

" disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

" make Ctrl-C as strong as Esc
nnoremap <C-c> <Esc>

" wrap ranges left/right
set whichwrap+=<,>,h,l,[,]

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" show whitespace
set list 

" use git instead
set nobackup

" keep 50 lines of command line history
set history=50

" show the cursor position all the time
set ruler

" display incomplete commands
set showcmd

" do incremental searching
set incsearch

" 4-col hard tabs
set tabstop=4 softtabstop=0 noexpandtab shiftwidth=4

" set line numbers
set number

" Don't use Ex mode, use Q for formatting
map Q gq

" treat C-u as a single operation
inoremap <C-U> <C-G>u<C-U>

" enable mouse
if has('mouse')
	set mouse=a
endif

" enable enhanced colors
if (has('termguicolors'))
	set termguicolors
endif

" syntax highlighting
if &t_Co > 2 || has('gui_running')
	syntax on
	set hlsearch
endif

" filetype indent detection
filetype plugin indent on

" sudo write
cmap w!! w !sudo tee > /dev/null %

if has('autocmd')
	augroup vimrcEx
		au!

		au FileType text setlocal textwidth=80

		" lambdant syntax highlighting
		au BufEnter,BufNewFile,BufRead *.lm set filetype=javascript

		" enable deoplete
		let g:deoplete#enable_at_startup = 1
		" let g:necoghc_enable_detailed_browse = 1
		" au FileType haskell setlocal omnifunc=necoghc#omnifunc

		" jump to the last known cursor position
		au BufReadPost *
			\ if line("'\"") >= 1 && line("'\"") <= line("$") |
			\   exe "normal! g`\"" |
			\ endif

	augroup END
else
	set autoindent
endif

" diff with original file
if !exists(':DiffOrig')
	command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		\ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
	set langnoremap
endif
