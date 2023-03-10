require('lazy').setup {
  require('themes'),

  { 'numToStr/Comment.nvim',
    config = true },

  { 'folke/which-key.nvim',
		lazy = true,
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require('which-key').setup({})
    end,
  },

	{ 'nvim-lualine/lualine.nvim',
		dependencies = { 'kyazdani42/nvim-web-devicons' },
		config = true },


	{ 'HiPhish/nvim-ts-rainbow2', 
  dependencies = {'nvim-treesitter/nvim-treesitter'} },

  { 'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function ()
			require('nvim-treesitter.configs').setup {
				ensure_installed = { 'scala', 'rust', 'python', 'lua', 'vim', 'fish' },
        highlight = { enable = true },
        rainbow = { enable = true },
			} 
		end
  },

  { 'folke/zen-mode.nvim',
    config = function()
      require("zen-mode").setup {
        window = { options = { relativenumber = false, number = false } },
        plugins = { tmux = { enabled = false } } -- This doesn't work. File bug?
      }
    end
  },


  --table.unpack(require('lsp').config),
}
