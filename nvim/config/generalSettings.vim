let g:python3_host_prog='C:/ProgramData/Anaconda3/python'
let g:python_host_prog='C:/ProgramData/Miniconda2/python'
" if !exists(g:python_host_prog)
"     let g:python_host_prog='C:/ProgramData/Miniconda2/python'
" endif
set path+=**
" Set to auto read when a file is changed from the outside
set autoread
" Use awesome features
set nocompatible " be iMproved
" create missing dirs
nnoremap <leader>md :!mkdir -p %:p:h<cr>
" allow moving cursor just after the last chraracter of the line
set virtualedit=onemore
set list
set list lcs=space:_,tab:\┊\             " show vertical lines  ['|', '¦', '┆', '┊']
"set listchars=space:_,tab:>~
" set listchars=tab:␉·
:filetype on
filetype plugin on
syntax enable
syntax on
filetype indent on               " Better indentation.
set inccommand=nosplit
set showmatch                  " Show matching brackets.
set number
set relativenumber                  " Show the line numbers on the left side.
set formatoptions+=o           " Continue comment marker in new lines.
"set expandtab                 " Insert spaces when TAB is pressed.
set tabstop=2                  " Render TABs using this many spaces.
"set expandtab
set shiftwidth=2               " Indentation amount for < and > commands.
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
set smartindent	               "# Enable smart-indent.
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
" Use Unix as the standard file type
set ffs=unix
set splitbelow
set splitright

set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js,*.prefab,*.meta,*.unity,*.asset,*.mp4,*.mp3,*.avi,*.mov,*.fbx,*.pdf,*.maya,*.blender,*.user,*.dwlt,*.db,*.pref
set wildignore+=*/bower_components/*,*/node_modules/*,*/__pycache__/*
set wildignore+=*/smarty/*,*/vendor/*,*/.git/*,*/.hg/*,*/.svn/*,*/.sass-cache/*,*/log/*,*/tmp/*,*/build/*,*/ckeditor/*,*/doc/*,*/source_maps/*,*/dist/*
set wildignore+=*/Temp/*,*/Library/*,*/Debug/*,*/Build/*,*/.gradle/*,*/obj/*,*/.idea/*,*/.vs/*,*/.vscode/*
" Enable folding
set foldmethod=indent
set foldlevel=99

" No annoying sound on errors
set noerrorbells
set novisualbell
set noeb vb t_vb=
set t_vb=
set tm=500
"set iskeyword+=- "To make vim treat dash separated words as a word text-object

:set wildoptions=pum
:set pumblend=20

" For regular expressions turn magic on
set magic

if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

set mouse=a
" <RightMouse> pops up a context menu
" <S-LeftMouse> extends a visual selection
set mousemodel=popup

" open diffs in vertical splits by default
set diffopt+=vertical

set linespace=4

if has('nvim-0.3.2') || has("patch-8.1.0360")
    set diffopt=filler,vertical,internal,algorithm:histogram,indent-heuristic
endif

let g:markdown_fenced_languages = ['html', 'python', 'bash=sh','javascript','viml=vim','csharp=cs','css','scss']

"I don't like my cursor line getting too close to the top or the bottom of the screen"
set scrolloff=3

set shortmess=a
