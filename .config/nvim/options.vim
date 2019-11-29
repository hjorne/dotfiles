set number relativenumber
set nu rnu

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
