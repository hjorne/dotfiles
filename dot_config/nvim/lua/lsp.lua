local M = {}

function M.lsp_manual_config() 
  require('lspconfig').rust_analyzer.setup {}
end

M.config = {
  { 'neovim/nvim-lspconfig',
    lazy = true
     },

  { 'scalameta/nvim-metals', 
    dependencies = { 'nvim-lua/plenary.nvim' } },
}

return M
