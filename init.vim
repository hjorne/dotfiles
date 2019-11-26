call plug#begin('~/.config/nvim/plugged')

" NERDTree
Plug 'scrooloose/nerdtree'

" Fuzzy Search
Plug 'junegunn/fzf.vim'

" LSP Implementation
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" SET OPTIONS

" Set hybrid line numbers (both relative and absolute line numbers
" simultaneously
set number relativenumber
set nu rnu

" Set automatic save on focus change
set autowrite

" SET MAPPINGS

