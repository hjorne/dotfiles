-- Set both line numbers in gutter
vim.opt.number = true

-- Set color scheme
vim.cmd('colorscheme gruvbox')

-- Set gruvbox light mode
vim.opt.background = 'dark'

-- Set automatic save on focus change
vim.opt.autowrite = true

-- Don't use tabs
vim.opt.expandtab = true

-- 2 space indents
vim.opt.shiftwidth = 4

-- Get rid of second bar, lightline supercedes
vim.opt.showmode = false

-- Enable git branch to be on bar
vim.g.lightline = {
      colorscheme = 'onehalfdark',
      active = {
          left = {
              { 'mode', 'paste' },
              { 'gitbranch', 'readonly', 'filename', 'modified' }
          }
      },
      component_function = {
          gitbranch = 'fugitive#head'
      }
}

-- Enable yank to system clipboard
vim.opt.clipboard = 'unnamed'

-- Better java syntax highlighting
vim.g.java_highlight_functions = 1

-- Set rainbow brackets enabled
vim.g.rainbow_active = 1

-- Set folding to syntax for Coc
vim.opt.foldmethod = 'syntax'

-- Disables folding by default when you open a file
vim.opt.foldenable = false

-- Set coc-status to status bar
vim.opt.statusline:append{[[%{coc#status()}]]}

-- Set true colors for neovim
vim.opt.termguicolors = true

-- Set foldlevel so that not everything is open
-- when folds are enabled
vim.opt.foldlevel = 99

-- Sane default for buffer handling
vim.opt.hidden = true

-- Triger `autoread` when files changes on disk
-- https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
-- https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
vim.cmd([[
augroup AutoRead
  autocmd!
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
          if mode() ~= 'c' and mode() ~= 'r' and mode() ~= '!' and mode() ~= 't' and getcmdwintype() == '' then
              checktime
          endif
augroup END
]])

-- Notification after file change
-- https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
vim.cmd([[
augroup FileChangedShellPost
  autocmd!
  autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
augroup END
]])

-- Enable 2-space tabs for javascript
vim.api.nvim_exec([[
augroup JsIndent
  autocmd!
  autocmd BufRead,BufNew *.js setlocal shiftwidth=2
augroup END
]], false)

-- Enable all Haskell syntax highlighting features
vim.g.haskell_enable_quantification = 1   -- to enable highlighting of `forall`
vim.g.haskell_enable_recursivedo = 1      -- to enable highlighting of `mdo` and `rec`
vim.g.haskell_enable_arrowsyntax = 1      -- to enable highlighting of `proc`
vim.g.haskell_enable_pattern_synonyms = 1 -- to enable highlighting of `pattern`
vim.g.haskell_enable_typeroles = 1        -- to enable highlighting of type roles
vim.g.haskell_enable_static_pointers = 

