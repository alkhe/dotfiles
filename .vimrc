" short circuit if evim
if v:progname =~? 'evim'
  finish
endif

" no vi compatibility
set nocp

" dein.vim
set rtp+=~/.vim/repos/github.com/Shougo/dein.vim
if dein#load_state('~/.vim')
  call dein#begin('~/.vim')

  call dein#add('Shougo/dein.vim')
  call dein#add('Shougo/vimproc.vim', { 'build': 'make' })
  call dein#add('vim-scripts/L9')

  " autocomplete
  call dein#add('Shougo/deoplete.nvim')

  " readline insert mode
  call dein#add('tpope/vim-rsi')

  " status bar
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')

  " git integration
  call dein#add('airblade/vim-gitgutter')

  " tmux integration
  call dein#add('christoomey/vim-tmux-navigator')

  " color schemes
  " call dein#add('joshdick/onedark.vim')
  call dein#add('tyrannicaltoucan/vim-quantum')
  " call dein#add('rhysd/vim-color-spring-night')
  " call dein#add('raphamorim/lucario')
  " call dein#add('dracula/vim')
  " call dein#add('YorickPeterse/happy_hacking.vim')
  " call dein#add('rakr/vim-two-firewatch')
  " call dein#add('tyrannicaltoucan/vim-deep-space')

  " syntax plugins
  call dein#add('pangloss/vim-javascript')
  " call dein#add('mxw/vim-jsx')
  " call dein#add('digitaltoad/vim-pug')
  " call dein#add('wavded/vim-stylus')
  " call dein#add('justinmk/vim-syntax-extra')
  " call dein#add('lambdatoast/elm.vim')
  " call dein#add('eagletmt/ghcmod-vim', { 'on_ft': 'haskell' })
  " call dein#add('eagletmt/neco-ghc', { 'on_ft': 'haskell' })
  " call dein#add('rust-lang/rust.vim')
  " call dein#add('zah/nim.vim')
  " call dein#add('jordwalke/vim-reason-loader')
  " call dein#add('facebook/reason', { 'rtp': 'editorSupport/VimReason' })

  call dein#end()
  call dein#save_state()
endif

" colors
if &t_Co > 2 || has('gui_running')
  syntax on
  set hlsearch
endif

if (has('termguicolors'))
  set termguicolors
endif

" let g:spring_night_high_contrast=[]
let g:quantum_black=1
set background=dark
colorscheme quantum
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

" switch panes faster
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" move by screen rows instead of lines
noremap j gj
noremap k gk

" make Ctrl-C as strong as Esc
noremap <C-c> <Esc>

" switch tab scheme
function TabToggle()
  if &expandtab
    set noexpandtab tabstop=4 shiftwidth=4
  else
    set expandtab tabstop=2 shiftwidth=2
  endif
endfunction

noremap <C-S-t> :call TabToggle()<CR>

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

" 2-col soft tabs
set tabstop=2 softtabstop=2 expandtab shiftwidth=2

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

" filetype indent detection
filetype plugin indent on

" sudo write
cmap w!! w !sudo tee > /dev/null %

if has('autocmd')
  augroup vimrcEx
    au!

    au FileType text setlocal textwidth=80

    au BufEnter,BufNewFile,BufRead *.lm set filetype=javascript
    au BufEnter,BufNewFile,BufRead *.vue set filetype=html

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

