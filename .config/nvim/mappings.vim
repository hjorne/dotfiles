let mapleader=" "

nmap <silent> <C-p> :NERDTreeToggle<CR>
nmap <silent> <Leader>fz :FZF<CR>
nmap <silent> <Leader>gf :GFiles<CR>
nmap <silent> <Leader>rg :Rg<CR>
nmap <silent> <Leader>rr :RG<CR>

tmap <silent> UU <C-\><C-n>

" Using tpope's unimpaired plugin for this
"nnoremap <silent> [b :bprevious<CR> 
"nnoremap <silent> ]b :bnext<CR> 
"nnoremap <silent> [B :bfirst<CR> 
"nnoremap <silent> ]B :blast<CR>

"nnoremap <silent> <C-[> :bprevious<CR> 
"nnoremap <silent> <C-]> :bnext<CR> 
"nnoremap <silent> [B :bfirst<CR> 
"nnoremap <silent> ]B :blast<CR>

nmap <silent> <Leader>gy :Goyo<CR>
nmap <leader>dd a<C-R>=strftime("%a, %d %b %Y %I:%M %p")<CR><Esc>
"imap <leader>dd <C-R>=strftime("%a, %d %b %Y %I:%M %p")<CR>
map <leader>r :NERDTreeFind<cr>

nnoremap <leader>gss :GitSessionSave<cr>
nnoremap <leader>gsl :GitSessionLoad<cr>
nnoremap <leader>gsd :GitSessionDelete<cr>
