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
  use 'github/copilot.nvim'

  -- Auto pairs
  use 'jiangmiao/auto-pairs'

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
        functions = { }
        variables = { }
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

