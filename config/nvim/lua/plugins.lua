-- recommended by nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    dependencies = {
      'nvim-lua/plenary.nvim'
    }
  },

   'rktjmp/lush.nvim',
  'RishabhRD/gruvy',

    {
    'luisiacc/gruvbox-baby', branch = 'main',
  },

  'folke/tokyonight.nvim',
  'tiagovla/tokyodark.nvim',
  'navarasu/onedark.nvim',
  'sainnhe/gruvbox-material',
  'sainnhe/everforest',

  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  },

  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      -- Useful status updates for LSP
      'j-hui/fidget.nvim',
      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim',
    },
  },

    -- little pictures/icons in LSP completion floating UI
    'onsails/lspkind.nvim',

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  },
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-nvim-lua',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',

  -- syntax
  -- Highlight, edit, and navigate code
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
  'nvim-treesitter/playground',
  'nvim-treesitter/nvim-treesitter-context',
  'nvim-treesitter/nvim-treesitter-textobjects',
  'jxnblk/vim-mdx-js',

  -- editor quality of life
  'google/vim-searchindex',
  'kevinoid/vim-jsonc',
  'dominikduda/vim_current_word',

  -- widgets
  -- { 'junegunn/fzf', run = function() vim.fn['fzf#install'](0) end },
  -- 'junegunn/fzf.vim',

  -- source control
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'lewis6991/gitsigns.nvim',

  -- motions
  'tpope/vim-surround',

  -- Text Objects
  'kana/vim-textobj-user',
  'vim-scripts/argtextobj.vim',
  'bkad/CamelCaseMotion',
  'kana/vim-textobj-entire',
  'numToStr/Comment.nvim',

  'lukas-reineke/indent-blankline.nvim',
  'tpope/vim-sleuth',

  'junegunn/vim-easy-align',

  -- tmux
  'christoomey/vim-tmux-navigator',

  -- nvim lua
  'b0o/mapx.nvim',



  'tpope/vim-eunuch',
  'tyru/open-browser.vim',
  'aklt/plantuml-syntax',
  'weirongxu/plantuml-previewer.vim',
  'Glench/Vim-Jinja2-Syntax',
  'scrooloose/vim-slumlord',
  'justinmk/vim-dirvish',
  { 'iamcco/markdown-preview.nvim', build = function() vim.fn['mkdp#util#install'](0) end },
  'machakann/vim-sandwich',
  'jiangmiao/auto-pairs',
  'ntpeters/vim-better-whitespace',
  'wellle/targets.vim',
  'edkolev/tmuxline.vim',

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },

  -- themes
  'rrethy/nvim-base16',
  'haishanh/night-owl.vim',
  { 'dracula/vim', name = 'dracula' },

  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function ()
      require'alpha'.setup(require'alpha.themes.startify'.config)
    end
  },

  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  },

  'nvim-tree/nvim-web-devicons',
  {'romgrk/barbar.nvim', dependencies = {'nvim-web-devicons'}},
})
