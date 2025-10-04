local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- File navigate
  use 'nvim-tree/nvim-tree.lua'
  use 'nvim-tree/nvim-web-devicons'
  use 'nvim-lualine/lualine.nvim'

  -- Syntax highlight
  use 'nvim-treesitter/nvim-treesitter'

  -- Github Copilot
  use {
    'github/copilot.vim',
    branch = 'release'
  }

  -- Auto pairs
  use 'jiangmiao/auto-pairs'

  -- Lsp
  use ({
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    -- For ease of installing LSP servers
    'neovim/nvim-lspconfig',
  })

  -- Completion & sources
  use ({
    'hrsh7th/nvim-cmp',         -- Completion plugin
    'hrsh7th/cmp-nvim-lsp',     -- LSP source for nvim-cmp
    'hrsh7th/cmp-buffer',       -- Buffer source for nvim-cmp
    'hrsh7th/cmp-path',         -- Path source for nvim-cmp
    'hrsh7th/cmp-cmdline',      -- Cmdline source for nvim-cmp
    'saadparwaiz1/cmp_luasnip', -- Snippets source for nvim-cmp
    'L3MON4D3/LuaSnip',         -- Snippets plugin
    'onsails/lspkind-nvim',     -- vscode-like pictograms
  })

  -- eslint && prettier
  use "mfussenegger/nvim-lint"
  use "stevearc/conform.nvim"

  -- Tokyo night
  use {
    "folke/tokyonight.nvim",
    config = function()
      -- Set up style and options before loading colorscheme
      vim.g.tokyonight_style = "night"
      vim.g.tokyonight_transparent = true
      vim.g.tokyonight_dim_inactive = true
      vim.g.tokyonight_terminal_colors = true

      vim.g.tokyonight_styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = { },
        variables = { },
        sidebars = "transparent"
      }

      vim.cmd("colorscheme tokyonight")

      vim.api.nvim_set_hl(0, 'Normal', { ctermbg = 'NONE', bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'NormalNC', { ctermbg = 'NONE', bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'VertSplit', { ctermbg = 'NONE', bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'StatusLine', { ctermbg = 'NONE', bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'LineNr', { ctermbg = 'NONE', bg = 'NONE' })      

    end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

