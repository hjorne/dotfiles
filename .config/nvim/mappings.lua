function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Set key mappings using the map function
vim.g.mapleader = " "

map('n', '<C-p>', ':NERDTreeToggle<CR>')
map('n', '<Leader>fz', ':FZF<CR>')
map('n', '<Leader>gf', ':GFiles<CR>')
map('n', '<Leader>rg', ':Rg<CR>')
map('n', '<Leader>rr', ':RG<CR>')

-- Might need to escape this character
map('t', 'UU', '<C-\><C-n>')

map('n', '<Leader>gy', ':Goyo<CR>')
--map('n', '<leader>dd', 'a<C-R>=strftime("%a, %d %b %Y %I:%M %p")<CR><Esc>')
map('n', '<leader>r', ':NERDTreeFind<CR>')

map('n', '<leader>gss', ':GitSessionSave<CR>')
map('n', '<leader>gsl', ':GitSessionLoad<CR>')
map('n', '<leader>gsd', ':GitSessionDelete<CR>')
