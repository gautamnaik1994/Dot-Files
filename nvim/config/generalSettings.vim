let g:python3_host_prog='C:/ProgramData/Anaconda3/python.exe'
let g:python_host_prog='C:/ProgramData/Anaconda2/python.exe'
" Set to auto read when a file is changed from the outside
set autoread
" Use awesome features
set nocompatible " be iMproved
" create missing dirs
nnoremap <leader>md :!mkdir -p %:p:h<cr>
set list lcs=tab:\│\             " show vertical lines
:filetype on
filetype plugin on
syntax enable
syntax on
filetype indent on                                " Better indentation.
set showmatch                  " Show matching brackets.
set number
set relativenumber                  " Show the line numbers on the left side.
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
" Use Unix as the standard file type
set ffs=unix
set splitbelow
set splitright

set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js
set wildignore+=*/bower_components/*,*/node_modules/*
set wildignore+=*/smarty/*,*/vendor/*,*/.git/*,*/.hg/*,*/.svn/*,*/.sass-cache/*,*/log/*,*/tmp/*,*/build/*,*/ckeditor/*,*/doc/*,*/source_maps/*,*/dist/*
" Enable folding
set foldmethod=indent
set foldlevel=99

" No annoying sound on errors
set noerrorbells
set novisualbell
set noeb vb t_vb=
set t_vb=
set tm=500

" For regular expressions turn magic on
set magic

if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
endif
