require('plugins')
require('tools')
require('plugin_config.telescope')

require'mapx'.setup{ global = true }

-- this is our single source of truth created above
local base16_theme_fname = vim.fn.expand(vim.env.HOME..'/.config/.base16_theme')

-- this function is the only way we should be setting our colorscheme
local function set_colorscheme(name)
    -- write our colorscheme back to our single source of truth
    vim.fn.writefile({name}, base16_theme_fname)
    -- set Neovim's colorscheme
    vim.cmd('colorscheme '..name)
    -- execute `kitty @ set-colors -c <color>` to change terminal window's
    -- colors and newly created terminal windows colors
    vim.loop.spawn('kitty', {
        args = {
            '@',
            '--to',
            'unix:/tmp/kitty-socket',
            'set-colors',
            '-c',
            string.format(vim.env.HOME..'/base16-kitty/colors/%s.conf', name)
        }
    }, nil)
end

set_colorscheme(vim.fn.readfile(base16_theme_fname)[1])

function update_color()
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

nnoremap('<leader>c', function()
    print('run this')
    update_color()
end)

---WORKAROUND
-- see https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation#packernvim
vim.api.nvim_create_autocmd({'BufEnter','BufAdd','BufNew','BufNewFile','BufWinEnter'}, {
  group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
  callback = function()
    vim.opt.foldmethod     = 'expr'
    vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
  end
})
---ENDWORKAROUND

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
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@call.outer",
        ["ic"] = "@call.inner",
      },
    },
  },
}
