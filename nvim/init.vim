""""""""""""""
" Plugins!!! "
""""""""""""""

call plug#begin('~/.vim/plugged')

Plug 'sheerun/vim-polyglot'
Plug 'haishanh/night-owl.vim'
Plug 'google/vim-searchindex'
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'codehearts/mascara-vim'
Plug 'scrooloose/nerdcommenter'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'Yggdroot/indentLine'
Plug 'ervandew/supertab'
Plug 'tpope/vim-fugitive'
Plug 'jparise/vim-graphql'
Plug 'tpope/vim-surround'
"

Plug 'flazz/vim-colorschemes'

Plug 'junegunn/vim-easy-align'

Plug 'liuchengxu/vim-clap'

" tmux
Plug 'christoomey/vim-tmux-navigator'

" Text Objects
Plug 'kana/vim-textobj-user'
Plug 'vim-scripts/argtextobj.vim'
Plug 'bkad/CamelCaseMotion'
Plug 'kana/vim-textobj-entire'
Plug 'tpope/vim-commentary'

Plug 'airblade/vim-gitgutter'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'tpope/vim-eunuch'
Plug 'tyru/open-browser.vim'
Plug 'aklt/plantuml-syntax'
Plug 'weirongxu/plantuml-previewer.vim'
Plug 'Glench/Vim-Jinja2-Syntax'
" Plug 'scrooloose/vim-slumlord'
"Plug 'justinmk/vim-dirvish'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'scrooloose/nerdtree'
Plug 'machakann/vim-sandwich'
Plug 'jiangmiao/auto-pairs'
Plug 'ntpeters/vim-better-whitespace'
Plug 'wellle/targets.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'morhetz/gruvbox'
Plug 'sonph/onehalf', { 'rtp': 'vim/' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Alredy used by polyglot
" Plug 'HerringtonDarkholme/yats.vim'
"

" themes
Plug 'hzchirs/vim-material'
Plug 'jdkanani/vim-material-theme'


" This plugin should always be last
Plug 'ryanoasis/vim-devicons'



call plug#end()

" set leader as space
let mapleader=' '
let g:vim_markdown_conceal = 0

" treat all numbers as decimals
set nrformats-=octal

" CamelCaseMotion config
let g:camelcasemotion_key = '<leader>'

" Awesome keymaps!!!
nnoremap <esc> :noh<CR><esc>
nnoremap <silent> gh :call CocAction('doHover')<CR>
nmap <silent> <Leader>m <Plug>(coc-diagnostic-prev)
nmap <silent> <Leader>n <Plug>(coc-diagnostic-next)
nnoremap <Leader>f :GoFmt<CR>

command! -nargs=0 Format :call CocAction('format')

" Go to definition in new split
" map <C-b> :NERDTreeToggle %<CR>
function! NERDTreeToggleInCurDir()
  " If NERDTree is open in the current buffer
  if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
    exe ":NERDTreeClose"
  else
    exe ":NERDTreeFind"
  endif
endfunction

nnoremap <silent> <C-b> :call NERDTreeToggleInCurDir()<CR>

" Create file in current directory
map <C-e> :e %:h/

" Comment block
nnoremap <Leader>cib viw<Leader>cc;

" navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Replace current worh with buffer!
map <Leader>p ciw<C-r>0<ESC>

" Tmuxline snapshot
nnoremap <Leader>tms:TmuxlineSnapshot! ~/.tmuxline.snapshot

inoremap jj <ESC>
" open vim config
noremap <leader>e :vsplit ~/.config/nvim/init.vim<CR>

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <leader>rn <Plug>(coc-rename)

nmap <leader>qf  <Plug>(coc-fix-current)

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* Rg 
  \ call fzf#vim#grep(
  \ "rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1,
  \ {'options': '--delimiter : --nth 4..'}, 
  \ <bang>0)

nnoremap <C-f> :Rg<CR>
nnoremap <C-p> :Files<CR>

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <Tab> and <S-Tab> to navigate the completion
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Close the preview window when completion is done
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" coc definitions keymap
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> <Leader>fd <C-w>v<C-w>w :call feedkeys("gd")<CR>
nmap <silent> <Leader>td :tab split<CR> feedkeys("gd")<CR>
nmap <silent> <Leader>fhd <C-w>s<C-w>w :call feedkeys("gd")<CR>
" nmap <silent> <Leader>ft <C-w>s<C-w>w :call feedkeys("gd")<CR>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Quickly edit and source config files
noremap <leader>ev :tabe ~/.config/nvim/init.vim<CR>
noremap <leader>es :tabe ~/.config/nvim/coc-settings.json<CR>
noremap <leader>s :source ~/.config/nvim/init.vim<CR>
noremap <leader>eg :tabe ~/.gitconfig<CR>
noremap <leader>ek :tabe ~/.config/kitty/kitty.conf<CR>
noremap <leader>et :tabe ~/.tmux.conf<CR>

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

set shiftwidth=2
set softtabstop=2
set number
set expandtab
set encoding=utf-8
set ignorecase
set textwidth=0
set conceallevel=0
set wrapmargin=0
set signcolumn=yes
set mouse=a
set cursorline
set number relativenumber             " set hybrid numbers

" ntpeters/vim-better-whitespace
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=0


" Preventing Bad Habits
" http://vimcasts.org/blog/2013/02/habit-breaking-habit-making/
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Theme config
" Support 24bit true colors
if (has("termguicolors"))
 set termguicolors
endif
syntax enable

""""""""""""""""""
" Color Scheme!! "
""""""""""""""""""
" Config "
let g:gruvbox_italic=1
" Theme "
" colorscheme night-owl
" colorscheme dracula
" colorscheme gruvbox
" colorscheme onehalflight
" let g:airline_theme='onehalfdark'
colorscheme onehalfdark
" colorscheme cobalt2
" colorscheme birds-of-paradise
" let g:airline_theme='onehalflight'

" Material theme https://github.com/hzchirs/vim-material
" Dark
" set background=dark
" colorscheme vim-material
" Palenight
" let g:material_style='palenight'
" set background=dark
" colorscheme vim-material
" Oceanic
" let g:material_style='oceanic'
" set background=dark
" colorscheme vim-material
" Light
" set background=light
" colorscheme vim-material
" Material Airline
" let g:airline_theme='material'

" Vim Material Theme https://github.com/jdkanani/vim-material-theme
" syntax enable
" set background=dark
" colorscheme material-theme
" light
" syntax enable
" set background=light
" colorscheme material-theme

" for clipboard support out of vim
set clipboard^=unnamedplus

" indentLine plugin config
let g:indentLine_char_list = ['|']

" make sign column same color as theme
let g:gitgutter_override_sign_column_highlight = 0
highlight clear SignColumn

" Polyglot
" let g:polyglot_disabled = ['typescript', 'tsx']

" vim-airline
" let g:airline_powerline_fonts = 1
" let g:airline_theme='night_owl'
" Flame looking arrow
"let g:airline_left_sep = "\uE0C0"

function! AirlineInit()
  " let g:airline_section_a = airline#section#create(['mode', ' ', 'foo'])
  " let g:airline_section_b = airline#section#create_left(['ffenc','file'])
  " let g:airline_section_c = airline#section#create(['%{getcwd()}'])
  let g:airline_section_a = airline#section#create(['mode'])
  let g:airline_section_b = ''
  " let g:airline_section_a = airline#section#createleft(['mode'])
endfunction
autocmd User AirlineAfterInit call AirlineInit()

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


" NERDCommenter
let g:NERDSpaceDelims = 1


" vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" remap increment
nnoremap <C-c> <C-a>


" Veonim config!!
if exists('veonim')
  set guifont=Dank\ Mono:h18
  nnoremap <silent> <C-p> :Veonim files<CR>
  nnoremap <silent> ,f :Veonim files<cr>
endif

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

if $VIM_CRONTAB == "true"
  set nobackup
  set nowritebackup
endif
