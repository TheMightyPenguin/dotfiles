lua require('init')

" set leader as space
let g:vim_markdown_conceal = 0

" for parcel hot reload to work
set backupcopy=yes

" treat all numbers as decimals
set nrformats-=octal

let g:camelcasemotion_key = '<leader>'

nnoremap <esc> :noh<CR><esc>

" Create file in current directory
map <C-e> :e %:h/

" Comment block
nnoremap <Leader>cib viw<Leader>cc;

" Replace current worh with buffer!
map <Leader>p ciw<C-r>0<ESC>

" Tmuxline snapshot
nnoremap <Leader>tms:TmuxlineSnapshot! ~/.tmuxline.snapshot

inoremap jj <ESC>
" open vim config
noremap <leader>e :vsplit ~/.config/nvim/init.vim<CR>

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Quickly edit and source config files
noremap <leader>ev :tabe ~/.config/nvim/init.vim<CR>
noremap <leader>ewt :tabe /mnt/c/Program\ Files/WezTerm/wezterm.lua<CR>
noremap <leader>s :source ~/.config/nvim/init.vim<CR>
noremap <leader>eg :tabe ~/.gitconfig<CR>
noremap <leader>ek :tabe ~/.config/kitty/kitty.conf<CR>
noremap <leader>et :tabe ~/.tmux.conf<CR>
noremap <leader>ez :tabe ~/.zshrc<CR>

" ntpeters/vim-better-whitespace
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=0


" Preventing Bad Habits
" http://vimcasts.org/blog/2013/02/habit-breaking-habit-making/
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" tmuxline config
let g:tmuxline_preset = {
      \'a'    : ['🐧'],
      \'win'  : ['#I', '#W'], 
      \'cwin' : ['#I', '#W'],
      \'z'    : ' #(cd #{pane_current_path}; git rev-parse --abbrev-ref HEAD)',
      \'options' : {'status-justify' : 'left'} }

" supertab
" tab from top to bottom order
let g:SuperTabContextDefaultCompletionType = '<c-n>'
let g:SuperTabDefaultCompletionType = '<C-n>'

" vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" remap increment
nnoremap <C-c> <C-a>

set splitright

let uname = substitute(system('uname'),'\n','','')
if uname == 'Linux'
  let lines = readfile("/proc/version")
  if lines[0] =~ "microsoft"

    " fix clipboard
    let g:clipboard = {
              \   'name': 'win32yank-wsl',
              \   'copy': {
              \      '+': 'win32yank.exe -i --crlf',
              \      '*': 'win32yank.exe -i --crlf',
              \   },
              \   'paste': {
              \      '+': 'win32yank.exe -o --lf',
              \      '*': 'win32yank.exe -o --lf',
              \   },
              \   'cache_enabled': 0,
              \ }

  endif
endif

if $VIM_CRONTAB == "true"
  set nobackup
  set nowritebackup
endif

let g:vim_current_word#highlight_delay = 0

let g:vim_json_conceal=0

