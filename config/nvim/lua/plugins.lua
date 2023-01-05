-- recommended by nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup({function(use)
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use 'rktjmp/lush.nvim'
  use 'RishabhRD/gruvy'
  use {
    'luisiacc/gruvbox-baby', branch = 'main'
  }
  use 'folke/tokyonight.nvim'
  use 'tiagovla/tokyodark.nvim'
  use 'navarasu/onedark.nvim'
  use 'sainnhe/gruvbox-material'
  use 'sainnhe/everforest'

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  use { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      'j-hui/fidget.nvim',

      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim',
    },
  }

  use 'onsails/lspkind.nvim'
  use { -- Autocompletion
    'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  }
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'

  -- syntax
  use { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  }
  use 'nvim-treesitter/playground'
  use 'nvim-treesitter/nvim-treesitter-context'
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  -- use 'sheerun/vim-polyglot'
  -- use 'jparise/vim-graphql'
  use 'jxnblk/vim-mdx-js'


  -- editor quality of life
  use 'google/vim-searchindex'
  use 'kevinoid/vim-jsonc'
  use 'dominikduda/vim_current_word'


  -- widgets
  use { 'junegunn/fzf', run = function() vim.fn['fzf#install'](0) end }
  use 'junegunn/fzf.vim'


  -- source control
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'lewis6991/gitsigns.nvim'

  -- motions
  use 'tpope/vim-surround'


  -- Text Objects
  use 'kana/vim-textobj-user'
  use 'vim-scripts/argtextobj.vim'
  use 'bkad/CamelCaseMotion'
  use 'kana/vim-textobj-entire'
  use 'numToStr/Comment.nvim'

  use 'lukas-reineke/indent-blankline.nvim'
  use 'tpope/vim-sleuth'

  use 'junegunn/vim-easy-align'

  use 'liuchengxu/vim-clap'

  -- tmux
  use 'christoomey/vim-tmux-navigator'

  -- nvim lua
  use 'b0o/mapx.nvim'

  use 'tpope/vim-eunuch'
  use 'tyru/open-browser.vim'
  use 'aklt/plantuml-syntax'
  use 'weirongxu/plantuml-previewer.vim'
  use 'Glench/Vim-Jinja2-Syntax'
  use 'scrooloose/vim-slumlord'
  use 'justinmk/vim-dirvish'
  use { 'iamcco/markdown-preview.nvim', run = function() vim.fn['mkdp#util#install'](0) end }
  use 'machakann/vim-sandwich'
  use 'jiangmiao/auto-pairs'
  use 'ntpeters/vim-better-whitespace'
  use 'wellle/targets.vim'
  use 'edkolev/tmuxline.vim'

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- themes
  use 'rrethy/nvim-base16'
  use 'haishanh/night-owl.vim'
  use { 'dracula/vim', as = 'dracula' }
  -- use { 'sonph/onehalf', rtp = 'vim/' }

  -- This plugin should always be last
  -- use 'ryanoasis/vim-devicons'
  use 'nvim-tree/nvim-web-devicons'

  if is_bootstrap then
    require('packer').sync()
  end
end,
config = {
  display = {
    open_fn = require('packer.util').float,
  }
}})

if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end
