call plug#begin('~/.config/nvim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'

" Fuzzy Search
Plug 'junegunn/fzf'

" LSP Implementation
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Haskell Syntax highlighting
Plug 'neovimhaskell/haskell-vim'  

Plug 'itchyny/lightline.vim'

" Git intigration
Plug 'tpope/vim-fugitive'

Plug 'tpope/vim-surround'

Plug 'enomsg/vim-haskellconcealplus'

Plug 'junegunn/goyo.vim'

Plug 'junegunn/limelight.vim'

call plug#end()
