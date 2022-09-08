local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

-- install packer if it's not installed
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end


return require('packer').startup({function()
  use 'wbthomason/packer.nvim'

  -- lsp
  use { 'neoclide/coc.nvim', branch = 'release' }

  -- syntax
  use 'sheerun/vim-polyglot'
  use 'jparise/vim-graphql'
  use 'jxnblk/vim-mdx-js'

  -- editor quality of life
  use 'google/vim-searchindex'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'scrooloose/nerdcommenter'
  use 'kevinoid/vim-jsonc'
  use 'dominikduda/vim_current_word'

  -- color schemes
  use 'haishanh/night-owl.vim'
  use 'folke/tokyonight.nvim'
  use 'flazz/vim-colorschemes'
  use { 'dracula/vim', as = 'dracula' }

  -- widgets
  use { 'junegunn/fzf', run = function() vim.fn['fzf#install'](0) end }
  use 'junegunn/fzf.vim'

  -- source control
  use 'tpope/vim-fugitive'

  -- motions
  use 'tpope/vim-surround'

  -- Text Objects
  use 'kana/vim-textobj-user'
  use 'vim-scripts/argtextobj.vim'
  use 'bkad/CamelCaseMotion'
  use 'kana/vim-textobj-entire'
  use 'tpope/vim-commentary'

  use 'Yggdroot/indentLine'
  use 'ervandew/supertab'


  use 'junegunn/vim-easy-align'

  use 'liuchengxu/vim-clap'

  -- tmux
  use 'christoomey/vim-tmux-navigator'


  use 'airblade/vim-gitgutter'
  use 'tpope/vim-eunuch'
  use 'tyru/open-browser.vim'
  use 'aklt/plantuml-syntax'
  use 'weirongxu/plantuml-previewer.vim'
  use 'Glench/Vim-Jinja2-Syntax'
  use 'scrooloose/vim-slumlord'
  use 'justinmk/vim-dirvish'
  use { 'iamcco/markdown-preview.nvim', run = function() vim.fn['mkdp#util#install'](0) end }
  use 'scrooloose/nerdtree'
  use 'machakann/vim-sandwich'
  use 'jiangmiao/auto-pairs'
  use 'ntpeters/vim-better-whitespace'
  use 'wellle/targets.vim'
  use 'edkolev/tmuxline.vim'
  use 'morhetz/gruvbox'
  use { 'sonph/onehalf', rtp = 'vim/' }

  -- themes
  use 'hzchirs/vim-material'
  use 'jdkanani/vim-material-theme'


  -- This plugin should always be last
  use 'ryanoasis/vim-devicons'

  if packer_bootstrap then
    require('packer').sync()
  end
end,
config = {
  display = {
    open_fn = require('packer.util').float,
  }
}})
