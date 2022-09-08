-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/victor/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/victor/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/victor/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/victor/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/victor/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  CamelCaseMotion = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/CamelCaseMotion"
  },
  ["Vim-Jinja2-Syntax"] = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/Vim-Jinja2-Syntax"
  },
  ["argtextobj.vim"] = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/argtextobj.vim"
  },
  ["auto-pairs"] = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/auto-pairs"
  },
  ["coc.nvim"] = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/coc.nvim"
  },
  dracula = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/dracula"
  },
  fzf = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/fzf"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/fzf.vim"
  },
  gruvbox = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/gruvbox"
  },
  indentLine = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/indentLine"
  },
  ["markdown-preview.nvim"] = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/markdown-preview.nvim"
  },
  nerdcommenter = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/nerdcommenter"
  },
  nerdtree = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/nerdtree"
  },
  ["night-owl.vim"] = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/night-owl.vim"
  },
  onehalf = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/onehalf/vim/"
  },
  ["open-browser.vim"] = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/open-browser.vim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plantuml-previewer.vim"] = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/plantuml-previewer.vim"
  },
  ["plantuml-syntax"] = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/plantuml-syntax"
  },
  supertab = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/supertab"
  },
  ["targets.vim"] = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/targets.vim"
  },
  ["tmuxline.vim"] = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/tmuxline.vim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/tokyonight.nvim"
  },
  ["vim-airline"] = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/vim-airline"
  },
  ["vim-airline-themes"] = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/vim-airline-themes"
  },
  ["vim-better-whitespace"] = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/vim-better-whitespace"
  },
  ["vim-clap"] = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/vim-clap"
  },
  ["vim-colorschemes"] = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/vim-colorschemes"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-devicons"] = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/vim-devicons"
  },
  ["vim-dirvish"] = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/vim-dirvish"
  },
  ["vim-easy-align"] = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/vim-easy-align"
  },
  ["vim-eunuch"] = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/vim-eunuch"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-gitgutter"] = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/vim-gitgutter"
  },
  ["vim-graphql"] = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/vim-graphql"
  },
  ["vim-jsonc"] = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/vim-jsonc"
  },
  ["vim-material"] = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/vim-material"
  },
  ["vim-material-theme"] = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/vim-material-theme"
  },
  ["vim-mdx-js"] = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/vim-mdx-js"
  },
  ["vim-polyglot"] = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/vim-polyglot"
  },
  ["vim-sandwich"] = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/vim-sandwich"
  },
  ["vim-searchindex"] = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/vim-searchindex"
  },
  ["vim-slumlord"] = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/vim-slumlord"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-textobj-entire"] = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/vim-textobj-entire"
  },
  ["vim-textobj-user"] = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/vim-textobj-user"
  },
  ["vim-tmux-navigator"] = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/vim-tmux-navigator"
  },
  vim_current_word = {
    loaded = true,
    path = "/Users/victor/.local/share/nvim/site/pack/packer/start/vim_current_word"
  }
}

time([[Defining packer_plugins]], false)
-- Runtimepath customization
time([[Runtimepath customization]], true)
vim.o.runtimepath = vim.o.runtimepath .. ",/Users/victor/.local/share/nvim/site/pack/packer/start/onehalf/vim/"
time([[Runtimepath customization]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: ".v:exception | echom "Please check your config for correctness" | echohl None')
end
