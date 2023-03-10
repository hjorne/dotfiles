local opt = vim.opt

-- Set color scheme
-- vim.cmd('colorscheme moonbow')

-- Set line numbers in gutter
opt.number = true
opt.relativenumber = true

-- Set automatic save on focus change
opt.autowrite = true

-- Fuck tabs, spaces4lyfe
opt.expandtab = true

-- 4 space indents
opt.shiftwidth = 4
opt.tabstop = 4 -- In case you need to use tabs, for whatever reason

-- Use system clipboard for all operations
opt.clipboard:append('unnamedplus')

-- Pulls colors from TUI. May cause problems?
-- vim.o.termguicolors = true

-- Enable mouse use for every mode
opt.mouse = 'a'

-- Sensible search case settings
opt.ignorecase = true
opt.smartcase = true

-- Stop highlighting previous search
opt.hlsearch = false

-- Soft wrapping. The default true, but in case you need to change
opt.wrap = true

-- Preserve identation for soft wrapping
opt.breakindent = true

-- Influences where the status line stays with multiple windows
opt.laststatus = 3
