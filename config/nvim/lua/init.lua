require('plugins')

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.number = true
vim.o.expandtab = true
vim.cmd [[set encoding=utf-8]]
vim.o.ignorecase = true
vim.o.textwidth = 0
vim.o.conceallevel = 0
vim.o.wrapmargin = 0
vim.o.cursorline = true
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.termguicolors = true
vim.cmd [[set number relativenumber]]
vim.o.clipboard = "unnamedplus"

require('tools')

-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

require 'mapx'.setup { global = true }

-- this is our single source of truth created above
local base16_theme_fname = vim.fn.expand(vim.env.HOME .. '/.config/base16_theme')

-- this function is the only way we should be setting our colorscheme
local function set_colorscheme(name)
  -- write our colorscheme back to our single source of truth
  vim.fn.writefile({ name }, base16_theme_fname)
  -- set Neovim's colorscheme
  require('base16-colorscheme').setup(name:gsub("base16(-)", ""), { telescope = false })
  -- execute `kitty @ set-colors -c <color>` to change terminal window's
  -- colors and newly created terminal windows colors
  vim.loop.spawn('kitty', {
    args = {
      '@',
      '--to',
      'unix:/tmp/kitty-socket',
      'set-colors',
      '-c',
      string.format(vim.env.HOME .. '/base16-kitty/colors/%s-256.conf', name)
    }
  }, nil)
end

set_colorscheme(vim.fn.readfile(base16_theme_fname)[1])

local function update_color()
  -- get our base16 colorschemes
  local colors = vim.fn.getcompletion('base16', 'color')
  -- we're trying to mimic VSCode so we'll use dropdown theme
  local theme = require('telescope.themes').get_dropdown()
  -- create our picker
  require('telescope.pickers').new(theme, {
    prompt = 'Change Base16 Colorscheme',
    finder = require('telescope.finders').new_table {
      results = colors
    },
    sorter = require('telescope.config').values.generic_sorter(theme),
    attach_mappings = function(bufnr)
      -- change the colors upon selection
      local actions = require "telescope.actions"
      local telescope_action_set = require "telescope.actions.set"
      local action_state = require "telescope.actions.state"
      local telescope_actions = require "telescope.actions"
      actions.select_default:replace(function()
        set_colorscheme(action_state.get_selected_entry().value)
        telescope_actions.close(bufnr)
      end)
      telescope_action_set.shift_selection:enhance({
        -- change the colors upon scrolling
        post = function()
          set_colorscheme(action_state.get_selected_entry().value)
        end
      })
      return true
    end
  }):find()
end

vim.keymap.set('n', '<leader>co', function()
  update_color()
end)

require 'nvim-web-devicons'.setup {
  color_icons = true;
  default = true;
}

require('lualine').setup {
  options = {
    -- theme = 'auto',
    component_separators = '|',
    section_separators = '',
  }
}

require('bufferline').setup {
  animation = true,
}

require('indent_blankline').setup {
  char = '┆',
  show_current_context = true,
  -- show_current_context_start = true,
}

require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
}

require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "astro",
    "typescript",
    "tsx",
    "graphql",
    "regex",
    "json",
    "json5",
    "javascript",
    "markdown",
    "markdown_inline",
    "yaml",
    "vim",
    "lua",
    "make",
    "jsdoc",
    "comment",
    "css",
    "sql",
    "rust",
    "html",
    "bash",
    "c"
  },
  highlight = { enable = true },
  playground = { enable = true },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@call.outer",
        ["ic"] = "@call.inner",
      },
    },
  },
}

require("treesitter-context").setup {
  enable = true,
}

require("telescope").setup {
  pickers = {
    -- colorscheme = {
    --   enable_preview = true
    -- }
  },
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
    -- borderchars for gruvbox baby
    -- borderchars = {
    --   prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
    --   results = { " " },
    --   preview = { " " },
    -- },
  },
}

-- pcall(require('telescope').load_extension, 'fzf')

vim.keymap.set('n', '<C-b>', function()
  vim.api.nvim_command('NvimTreeToggle')
end, { desc = 'toggles tree view' })

-- telescope keymaps
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  rust_analyzer = {},
  tsserver = {},
  html = {},
  graphql = {},
  cssls = {},
  -- lua_ls = {},
  -- sumneko_lua = {
  --   Lua = {
  --     workspace = { checkThirdParty = false },
  --     telemetry = { enable = false },
  --   },
  -- },
}

-- Setup neovim lua configuration
require('neodev').setup()
--
-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

-- Turn on lsp status information
require('fidget').setup()

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'
local lspkind = require('lspkind')

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = "nvim_lua" },
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'luasnip' },
    { name = 'buffer', keyword_length = 5 }
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
      menu = {
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[api]",
        path = "[path]",
        luasnip = "[snip]",
      }
    })
  },
  experimental = {
    ghost_text = true,
  }
}

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  },
  formatting = {
    format = lspkind.cmp_format({
      menu = {
        buffer = '[buf]',
      }
    })
  },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
  formatting = {
    format = lspkind.cmp_format({
      menu = {
        path = '[path]',
        cmdline = '[CMD]',
      }
    })
  },
})

require("nvim-tree").setup {
  update_focused_file = {
    enable = true,
  },
}

require('Comment').setup()

local vim = vim
local api = vim.api
local M = {}

-- function to create a list of commands and convert them to autocommands
-------- This function is taken from https://github.com/norcalli/nvim_utils
function M.nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    api.nvim_command('augroup ' .. group_name)
    api.nvim_command('autocmd!')
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten { 'autocmd', def }, ' ')
      api.nvim_command(command)
    end
    api.nvim_command('augroup END')
  end
end

local autoCommands = {
  open_folds = {
    { "BufReadPost,FileReadPost", "*", "normal zR" }
  }
}

M.nvim_create_augroups(autoCommands)

if vim.g.neovide then
  vim.cmd [[set guifont=Iosevka\ Nerd\ Font:h18]]
  vim.g.neovide_input_use_logo = 1 -- enable use of the logo (cmd) key
  vim.keymap.set('n', '<D-s>', ':w<CR>') -- Save
  vim.keymap.set('v', '<D-c>', '"+y') -- Copy
  vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
  vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
  vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
  vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode

  vim.o.winblend = 70
  vim.o.pumblend = 70
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0
  -- vim.g.neovide_cursor_vfx_mode = "pixiedust"
end

vim.g.neovide_input_use_logo = 1
vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true })

-- Helper function for transparency formatting
-- local alpha = function()
--   return string.format("%x", math.floor(255 * (vim.g.neovide_transparency_point or 0.8)))
-- end
-- -- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
-- vim.g.neovide_transparency = 1
-- vim.g.transparency = 1
-- vim.g.neovide_backgrrailgunound_color = "#0f1117" .. alpha()

