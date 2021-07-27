" Set both line numbers in gutter
set number

" Set color scheme
colorscheme gruvbox

" Set gruvbox light mode
set background=dark

" Set automatic save on focus change
set autowrite

" Don't use tabs
set expandtab 

" 2 space indents
set shiftwidth=4

" Get rid of second bar, lightline supercedes
set noshowmode

" Enable git branch to be on bar
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }


" Enable yank to system clipboard
set clipboard=unnamed

" Better java syntax highlighting
let g:java_highlight_functions = 1

" Set rainbow brackets enabled
let g:rainbow_active = 1

" Set folding to syntax for Coc
set foldmethod=syntax

" Disables folding by default when you open a file
set nofoldenable

" Set coc-status to status bar
set statusline^=%{coc#status()}

" Set true colors for neovim
set termguicolors

" Set foldlevel so that not everything is open
" when folds are enabled
set foldlevel=99

" Sane default for buffer handling
set hidden

" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
    autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
            \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif

" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" Enable 2-space tabs for javascript
au BufRead,BufNew *.js set shiftwidth=2
