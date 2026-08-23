-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Install `lazy.nvim` plugin manager and load plugins ]]
--  See lua/config/lazy.lua for lazy.nvim setup
require 'config.lazy'

-- [[ Setting options ]]
--  See lua/config/options.lua for all vim options
require 'config.options'

-- [[ Basic Keymaps ]]
--  See lua/config/keymaps.lua for general keymaps
require 'config.keymaps'

-- [[ Basic Autocommands ]]
--  See lua/config/autocmds.lua for autocommands
require 'config.autocmds'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
