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

" Enable vimwiki autosave
let g:vimwiki_autowriteall = 1
