local theme = 'tokyonight'
vim.opt.background = 'dark'
vim.opt.termguicolors = true

local configs = {
  { 'ellisonleao/gruvbox.nvim',
    config = function () vim.cmd([[colorscheme gruvbox]]) end 
  },

  { 'arturgoms/moonbow.nvim',
    config = function () vim.cmd([[colorscheme moonbow]]) end 
  },

  { 'sainnhe/everforest',
    config = function () 
      -- soft, medium, hard
      vim.g.everforest_background = 'hard'
      vim.cmd([[colorscheme everforest]]) 
    end 
  },

  { 'catppuccin/nvim',
    config = function () 
      -- catppuccin, catppuccin-latte, catppuccin-frappe
      -- catppuccin-macchiato, catppuccin-mocha
      vim.cmd([[colorscheme catppuccin-frappe]]) 
    end 
  },

  { 'folke/tokyonight.nvim',
    config = function () 
			-- tokyonight, tokyonight-night, tokyonight-storm
			-- tokyonight-day, tokyonight-moon
      vim.cmd([[colorscheme tokyonight-night]]) 
    end 
  },
}

for i=1,#configs do
  local name = configs[i][1]
  if string.find(name, theme) then
    configs[i].lazy = false
    configs[i].priority = 1000
    return configs[i]
  end
end

error('No theme found')
