if empty(glob('~/AppData/Local/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/AppData/Local/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/AppData/Local/nvim/bundle')
Plug 'editorconfig/editorconfig-vim'
Plug 'zchee/deoplete-jedi'
" Plug 'tpope/vim-sensible'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/taglist.vim'
"Plug 'mhartington/oceanic-next'"
Plug 'gautamnaik1994/oceanic-next'
Plug 'vim-airline/vim-airline-themes'
Plug 'equalsraf/neovim-gui-shim'
"Plug 'townk/vim-autoclose'
Plug 'mattn/emmet-vim'
Plug 'prettier/vim-prettier', {'do': 'npm install','for': ['javascript', 'css', 'scss', 'json']}
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
" Plug 'vim-syntastic/syntastic'
Plug 'w0rp/ale'
Plug 'ryanoasis/vim-devicons'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'tmhedberg/SimpylFold'
Plug 'vim-scripts/indentpython.vim'
Plug 'nvie/vim-flake8'
" Plug 'Valloric/YouCompleteMe'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Raimondi/delimitMate'
Plug 'ternjs/tern_for_vim', {'for': ['javascript', 'javascript.jsx'], 'do': 'npm install' }
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'carlitux/deoplete-ternjs', {'do': 'npm install -g tern', 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'scrooloose/nerdcommenter'
Plug 'morhetz/gruvbox'
Plug 'kien/rainbow_parentheses.vim'
Plug 'liuchengxu/space-vim-dark'
Plug 'rakr/vim-one'
Plug 'mhinz/vim-signify'
"Plug 'othree/yajs.vim'
"Plug 'othree/html5.vim'
"Plug 'othree/es.next.syntax.vim'
Plug 'joshdick/onedark.vim'
Plug 'NLKNguyen/papercolor-theme'
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
" Enable folding with the spacebar
" nnoremap <space> za

" move vertically by visual line
nnoremap j gj
nnoremap k gk

"""""""""""""""""""""""""""""""""Autocommands""""""""""""""""""""""""""""""""""""""""""""
augroup autosourcing
	autocmd!
	autocmd BufWritePost init.vim source %  "Automatically source file vimrc file
augroup END

"""""""""""""""""""""""""""""""""Theme & Colors""""""""""""""""""""""""""""""""""""""""""""
"colorscheme gruvbox

"set background=dark " for the dark version
"colorscheme OceanicNext

"let g:gruvbox_contrast_dark = 'hard'
" let g:gruvbox_improved_strings = 1
"let g:oceanic_next_terminal_bold = 1
"let g:oceanic_next_terminal_italic = 1"

"colorscheme space-vim-dark"
"let g:space_vim_dark_background = 233
"color space-vim-dark"

"colorscheme one
"set background=dark " for the dark version
"let g:one_allow_italics = 1 "

colorscheme onedark
set background=dark


"colorscheme PaperColor

"""""""""""""""""""""""""""""""""Functions""""""""""""""""""""""""""""""""""""""""""""
if (has("termguicolors"))
 set termguicolors
endif

"""""""""""""""""""""""""""""""""Settings""""""""""""""""""""""""""""""""""""""""""""
set list lcs=tab:\│\             " show vertical lines
:filetype on
filetype plugin on
syntax enable
syntax on
filetype indent on                                " Better indentation.
set showmatch                  " Show matching brackets.
set number                     " Show the line numbers on the left side.
set formatoptions+=o           " Continue comment marker in new lines.
"set expandtab                 " Insert spaces when TAB is pressed.
set tabstop=2                  " Render TABs using this many spaces.
set expandtab
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
set cursorline         		   " highlight current line
set showcmd             	   " show command in bottom bar
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
" Enable folding
set foldmethod=indent
set foldlevel=99
" Automatically clean trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e
" Python Specific Settings
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
au BufRead,BufNewFile syn region xmlTagName matchgroup=xmlTag start=+</+ end=+>+

let python_highlight_all=1


""""""""""""""""""""""""""""""""rainbow paretnesis""""""""""""""""""""""""""""""""""""""""""""
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

"""""""""""""""""""""""""""""""""vim jsx""""""""""""""""""""""""""""""""""""""""""""
let g:jsx_ext_required = 0
"highlight link xmlEndTag xmlTag
"hi link xmlEndTag xmlTag"


"""""""""""""""""""""""""""""""""Indent line""""""""""""""""""""""""""""""""""""""""""""

let g:indentLine_char = '│'

"""""""""""""""""""""""""""""""""" omnifuncs""""""""""""""""""""""""""""""""""""""""""""
augroup omnifuncs
  autocmd!
  autocmd FileType css,scss setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  "autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end


"""""""""""""""""""""""""""""""""Deoplete""""""""""""""""""""""""""""""""""""""""""""
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_camel_case = 1
"let g:deoplete#enable_refresh_always = 1
" let g:deoplete#max_abbr_width = 0
" let g:deoplete#max_menu_width = 0
" let g:deoplete#omni#input_patterns = get(g:,'deoplete#omni#input_patterns',{})
" call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])

" let g:tern_request_timeout = 1
" let g:tern_request_timeout = 6000
" let g:tern#command = ["tern"]
" let g:tern#arguments = ["--persistent"]
" let g:deoplete#sources#javascript_support = 1


if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
" "<TAB>: completion.
 "inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" "inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
  \ 'tern#Complete',
   \ 'jspc#omni'
\]
set completeopt=longest,menuone,preview
" let g:deoplete#sources = {}
" let g:deoplete#sources['javascript.jsx'] = ['file', 'ultisnips', 'ternjs']
" let g:tern#command = ['tern']
" let g:tern#arguments = ['--persistent']

" let g:deoplete#sources#ternjs#filetypes = [
"                 \ 'jsx',
"                 \ 'javascript.jsx',
"                 \ ]

"""""""""""""""""""""""""""""""""Ultisnip""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsEditSplit="vertical"
autocmd FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:UltiSnipsExpandTrigger="<C-j>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
let g:UltiSnipsSnippetDirectories = ['~/AppData/Local/nvim/UltiSnips', 'UltiSnips']

"""""""""""""""""""""""""""""""""tern""""""""""""""""""""""""""""""""""""""""""""
if exists('g:plugs["tern_for_vim"]')
  let g:tern_show_argument_hints = 'on_hold'
  let g:tern_show_signature_in_pum = 1
  autocmd FileType javascript setlocal omnifunc=tern#Complete
endif
autocmd FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>


"""""""""""""""""""""""""""""""""Nerd Tree""""""""""""""""""""""""""""""""""""""""""""
map <C-n> :NERDTreeToggle<CR>
autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" let g:NERDTreeDirArrowExpandable = '▸'
" let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeMinimalUI=1
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
\| endif



"""""""""""""""""""""""""""""""""Airline""""""""""""""""""""""""""""""""""""""""""""

let g:airline_theme='base16_spacemacs'
let g:airline#extensions#tabline#enabled = 2
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#ale#enabled = 1

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

else
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
let g:prettier#config#print_width = 80


let g:prettier#config#tab_width = 2

let g:prettier#config#use_tabs = 'true'

let g:prettier#config#semi = 'true'

let g:prettier#config#single_quote = 'true'

" print spaces between brackets
" Prettier default: true
let g:prettier#config#bracket_spacing = 'true'

" put > on the last line instead of new line
" Prettier default: false
let g:prettier#config#jsx_bracket_same_line = 'false'
" avoid|always
" Prettier default: avoid
let g:prettier#config#arrow_parens = 'always'
" none|es5|all
" Prettier default: none
let g:prettier#config#trailing_comma = 'all'
" let g:prettier#autoformat = 0
let g:prettier#exec_cmd_async = 1
let g:prettier#config#parser = 'babylon'
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync

"""""""""""""""""""""""""""""""""Ale""""""""""""""""""""""""""""""""""""""""""""
"let g:ale_sign_error = '●' " Less aggressive than the default '>>'
"let g:ale_sign_warning = '--'
let g:ale_lint_on_enter = 0 " Less distracting when opening a new file
let g:ale_emit_conflict_warnings = 0
let g:ale_set_highlights = 0

"""""""""""""""""""""""""""""""""CtrlP""""""""""""""""""""""""""""""""""""""""""""

"let g:ctrlp_custom_ignore = 'node_modules\DS_Store\|git'
"let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
"let g:ctrlp_cmd='CtrlP :pwd'

"""""""""""""""""""""""""""""""""SimplyFold""""""""""""""""""""""""""""""""""""""""""""
let g:SimpylFold_docstring_preview=1

"""""""""""""""""""""""""""""""""delimitMate"""""""""""""""""""""""""""""""""""""""""""
  " delimitMate fixes
imap <M-Left> <Plug>delimitMateC-Left
imap <M-Right> <Plug>delimitMateC-Right
imap <D-Left> <Plug>delimitMateHome
imap <D-Right> <Plug>delimitMateEnd

"""""""""""""""""""""""""""""""""vim-syntastic"""""""""""""""""""""""""""""""""""""""""""
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
