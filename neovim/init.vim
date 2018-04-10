if empty(glob('~/AppData/Local/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/AppData/Local/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/AppData/Local/nvim/bundle')

Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/taglist.vim'
Plug 'mhartington/oceanic-next'
Plug 'vim-airline/vim-airline-themes'
Plug 'equalsraf/neovim-gui-shim'
Plug 'townk/vim-autoclose'
Plug 'mattn/emmet-vim'
Plug 'prettier/vim-prettier', {'do': 'npm install','for': ['javascript', 'css', 'scss', 'json']}
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
" Plug 'vim-syntastic/syntastic'
Plug 'w0rp/ale'
" Plug 'ryanoasis/vim-devicons'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-surround'
call plug#end()



"""""""""""""""""""""""""""""""""Mappings""""""""""""""""""""""""""""""""""""""""""""
let mapleader= ","
"Open Vim file
nmap <Leader>ev :tabedit $MYVIMRC<cr>
nmap <Leader><space> :nohl<cr> 

"Split Management
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-L> <C-W><C-L>
nmap <C-H> <C-W><C-H>

"Code folding
nmap <Leader>f0 :set foldlevel=0<CR>
nmap <Leader>f1 :set foldlevel=1<CR>
nmap <Leader>f2 :set foldlevel=2<CR>
nmap <Leader>f3 :set foldlevel=3<CR>
nmap <Leader>f4 :set foldlevel=4<CR>
nmap <Leader>f5 :set foldlevel=5<CR>
nmap <Leader>f6 :set foldlevel=6<CR>
nmap <Leader>f7 :set foldlevel=7<CR>
nmap <Leader>f8 :set foldlevel=8<CR>
nmap <Leader>f9 :set foldlevel=9<CR>

"""""""""""""""""""""""""""""""""Autocommands""""""""""""""""""""""""""""""""""""""""""""
augroup autosourcing
	autocmd!
	autocmd BufWritePost init.vim source %  "Automatically source file vimrc file
augroup END

"""""""""""""""""""""""""""""""""Theme & Colors""""""""""""""""""""""""""""""""""""""""""""
colorscheme OceanicNext
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1


"""""""""""""""""""""""""""""""""Functions""""""""""""""""""""""""""""""""""""""""""""
if (has("termguicolors"))
 set termguicolors
endif

"""""""""""""""""""""""""""""""""Settings""""""""""""""""""""""""""""""""""""""""""""
syntax enable
syntax on
set showmatch                  " Show matching brackets.
set number                     " Show the line numbers on the left side.
set formatoptions+=o           " Continue comment marker in new lines.
"set expandtab                 " Insert spaces when TAB is pressed.
set tabstop=2                  " Render TABs using this many spaces.
set shiftwidth=4               " Indentation amount for < and > commands.
set nojoinspaces 
set t_Co=256
set encoding=utf-8
set hlsearch                   " Highlight matching search patterns
set incsearch                  " Enable incremental search
set ignorecase                 " Include matching uppercase words with lowercase search term
set smartcase                  " Include only uppercase words with uppercase search term
set nowrap	                   "# Wrap lines
set showbreak=+++	             "# Wrap-broken line prefix
set textwidth=100	             "# Line wrap (number of cols)
set showmatch	                 "# Highlight matching brace
"set spell	                   "# Enable spell-checking
set errorbells	               "# Beep or flash screen on errors
set visualbell	               "# Use visual bell (no beeping)
set autoindent	               "# Auto-indent new lines
set smartindent	               "# Enable smart-indent
set smarttab	                 "# Enable smart-tabs
set softtabstop=2	             "# Number of spaces per Tab
set ruler	                   "# Show row and column ruler information
set showtabline=2	             "# Show tab bar
set undolevels=1000	           "# Number of undo levels
set backspace=indent,eol,start "# Backspace behaviour
set laststatus=2
set ttimeoutlen=50 
set autochdir
set ff=unix
set splitbelow
set splitright
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows


"""""""""""""""""""""""""""""""""Nerd Tree""""""""""""""""""""""""""""""""""""""""""""
map <C-n> :NERDTreeToggle<CR>
autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
\| endif



"""""""""""""""""""""""""""""""""Airline""""""""""""""""""""""""""""""""""""""""""""

let g:airline_theme='base16_spacemacs'
let g:airline#extensions#tabline#enabled = 2
let g:airline#extensions#tabline#fnamemod = ':t'

if exists("g:gui_oni")
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
 " unicode symbols
  let g:airline_left_sep = ''
  let g:airline_left_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_sep = ''
  let g:airline_symbols.crypt = ''
  let g:airline_symbols.linenr = ''
  let g:airline_symbols.linenr = ''
  let g:airline_symbols.linenr = ''
  let g:airline_symbols.linenr = ''
  let g:airline_symbols.maxlinenr = ''
  let g:airline_symbols.maxlinenr = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.paste = ''
  let g:airline_symbols.paste = ''
  let g:airline_symbols.paste = ''
  let g:airline_symbols.spell = ''
  let g:airline_symbols.notexists = ''
  let g:airline_symbols.whitespace = ''
  " powerline symbols

elseif
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
  let g:airline_powerline_fonts = 1
  let g:airline_left_sep = '»'
  let g:airline_left_sep = '▶'
  let g:airline_right_sep = '«'
  let g:airline_right_sep = '◀'
  let g:airline_symbols.crypt = '🔒'
  let g:airline_symbols.linenr = '☰'
  let g:airline_symbols.linenr = '␊'
  let g:airline_symbols.linenr = '␤'
  let g:airline_symbols.linenr = '¶'
  let g:airline_symbols.maxlinenr = ''
  let g:airline_symbols.maxlinenr = '㏑'
  let g:airline_symbols.branch = '⎇'
  let g:airline_symbols.paste = 'ρ'
  let g:airline_symbols.paste = 'Þ'
  let g:airline_symbols.paste = '∥'
  let g:airline_symbols.spell = 'Ꞩ'
  let g:airline_symbols.notexists = '∄'
  let g:airline_symbols.whitespace = 'Ξ'
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = '☰'
  let g:airline_symbols.maxlinenr = ''
endif


"""""""""""""""""""""""""""""""""Emmet""""""""""""""""""""""""""""""""""""""""""""
let g:user_emmet_mode='a'    "enable all function in all mode.
let g:user_emmet_settings = {
  \  'javascript.jsx' : {
    \      'extends' : 'jsx',
    \  },
  \}

"""""""""""""""""""""""""""""""""Prettier""""""""""""""""""""""""""""""""""""""""""""
let g:prettier#exec_cmd_path = "~/AppData/Local/nvim/bundle/vim-prettier/node_modules/.bin/prettier"
" let g:prettier#autoformat = 0
let g:prettier#exec_cmd_async = 1
let g:prettier#config#parser = 'babylon'
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync


"""""""""""""""""""""""""""""""""Ale""""""""""""""""""""""""""""""""""""""""""""
let g:ale_sign_error = '●' " Less aggressive than the default '>>'
let g:ale_sign_warning = '.'
let g:ale_lint_on_enter = 0 " Less distracting when opening a new file

"""""""""""""""""""""""""""""""""CtrlP""""""""""""""""""""""""""""""""""""""""""""

let g:ctrlp_custom_ignore = 'node_modules\DS_Store\|git'
