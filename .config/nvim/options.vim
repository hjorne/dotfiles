
" Set both absolute and relative numbers. This enables
" relative numbering but absolute on cursor
set number relativenumber
set nu rnu

" Set color scheme
"colorscheme gruvbox

" Set gruvbox light mode
set background=light

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

" Needed for vimwiki for some reason
set nocompatible
filetype plugin on
syntax on

" Set vimwiki syntax to markdown
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'},{'path': '~/Dropbox/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

" Set auto-wrap text width to 80 when in markdown only
au BufRead,BufNewFile *.md setlocal textwidth=80

" Disable coc auto-suggestions in markdown only
autocmd FileType markdown let b:coc_suggest_disable = 1

" Enable vimwiki markdown links
let g:vimwiki_markdown_link_ext = 1

" Enable markdown fold
let g:markdown_folding = 1
