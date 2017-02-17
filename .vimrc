" short circuit if evim
if v:progname =~? "evim"
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

" call dein#add('AutoComplPop')
call dein#add('Shougo/deoplete.nvim')
call dein#add('tpope/vim-rsi')

call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')

call dein#add('joshdick/onedark.vim')
" call dein#add('raphamorim/lucario')
" call dein#add('dracula/vim')
" call dein#add('YorickPeterse/happy_hacking.vim')
" call dein#add('MvanDiemen/ghostbuster')
" call dein#add('rakr/vim-two-firewatch')
" call dein#add('tyrannicaltoucan/vim-deep-space')
" call dein#add('rakr/vim-one')

" call dein#add('eagletmt/ghcmod-vim', { 'on_ft': 'haskell' })
" call dein#add('eagletmt/neco-ghc', { 'on_ft': 'haskell' })
" call dein#add('rust-lang/rust.vim')
" call dein#add('zah/nim.vim')
" call dein#add('jordwalke/vim-reason-loader')
" call dein#add('facebook/reason', { 'rtp': 'editorSupport/VimReason' })
call dein#add('pangloss/vim-javascript')
call dein#add('mxw/vim-jsx')
call dein#add('justinmk/vim-syntax-extra')
call dein#add('lambdatoast/elm.vim')

call dein#add('airblade/vim-gitgutter')

call dein#end()

" colors
set background=dark
colorscheme onedark
let g:airline_theme='hybrid'

" react syntax
let g:js_ext_required = 0

" sql fix Ctrl-C
let g:ftplugin_sql_omni_key = '<C-j>'

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

" make Ctrl-C as strong as Ctrl-[
nnoremap <C-c> <Esc>

" wrap left/right
set whichwrap+=<,>,h,l,[,]

" show whitespace
set list

" if has("vms").
set nobackup		" do not keep a backup file, use versions instead
" git is fine okay
" else
"  set backup		" keep a backup file (restore to previous version)
"  set undofile		" keep an undo file (undo changes after closing)
" endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" 4-col hard tabs
set tabstop=4 softtabstop=0 noexpandtab shiftwidth=4

" set line numbers
set number

" mouse/GUI
if has('mouse')
	set mouse=a
endif

if (has("termguicolors"))
	set termguicolors
endif

" syntax highlighting
if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
endif

" filetype indent detection
filetype plugin indent on

" sudo write
cmap w!! w !sudo tee > /dev/null %

if has("autocmd")

	" Put these in an autocmd group, so that we can delete them easily.
	augroup vimrcEx
		au!

		" au BufRead,BufNewFile *.lm setf javascript

		" For all text files set 'textwidth' to 78 characters.
		au FileType text setlocal textwidth=78

		au FileType javascript set formatprg=prettier\ --stdin
		au BufEnter,BufNewFile,BufRead *.lm set filetype=javascript

		" let g:deoplete#enable_refresh_always = 1
		" let g:deoplete#auto_complete_delay = 0
		" let g:necoghc_enable_detailed_browse = 1
		" au FileType haskell setlocal omnifunc=necoghc#omnifunc
		let g:deoplete#enable_at_startup = 1

		" When editing a file, always jump to the last known cursor position.
		" Don't do it when the position is invalid or when inside an event handler
		" (happens when dropping a file on gvim).
		au BufReadPost *
					\ if line("'\"") >= 1 && line("'\"") <= line("$") |
					\   exe "normal! g`\"" |
					\ endif

	augroup END

else

	set autoindent		" always set autoindenting on

endif " has("autocmd")

" diff with original file
if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
				\ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
	set langnoremap
endif
