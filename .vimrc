" short circuit if evim
if v:progname =~? "evim"
  finish
endif

" no vi compatibility
set nocp

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" if has("vms")
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

" mouse/GUI
if has('mouse')
  set mouse=a
endif

" syntax highlighting
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

if has("autocmd")

  " filetype indent detection
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
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
