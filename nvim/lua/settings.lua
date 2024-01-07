local g          = vim.g
local o          = vim.o

HOME             = os.getenv("HOME")

g.mapleader      = ','
g.maplocalleader = ','

-- basic settings
o.encoding       = "utf-8"
o.backspace      = "indent,eol,start" -- backspace works on every char in insert mode
o.completeopt    = 'menuone,noselect'
o.history        = 1000
-- o.dictionary = '/usr/share/dict/words'
o.startofline    = true

-- Mapping waiting time
o.timeout        = false
o.ttimeout       = true
o.ttimeoutlen    = 50

-- Display
o.showmatch      = true -- show matching brackets
o.scrolloff      = 3    -- always show 3 rows from edge of the screen
o.synmaxcol      = 300  -- stop syntax highlight after x lines for performance
o.laststatus     = 2    -- always show status line
o.relativenumber = true

o.list           = false -- do not display white characters
o.foldenable     = true
o.foldlevel      = 4 -- limit folding to 4 levels
o.foldmethod     = 'syntax' -- use language syntax to generate folds
o.wrap           = false --do not wrap lines even if very long
o.eol            = false -- show if there's no eol char
o.showbreak      = '↪' -- character to show when line is broken

-- Sidebar
o.number         = true  -- line number on the left
o.numberwidth    = 3     -- always reserve 3 spaces for line number
o.signcolumn     = 'yes' -- keep 1 column for coc.vim  check
o.modelines      = 0
o.showcmd        = true  -- display command in bottom bar

-- Search
o.incsearch      = true -- starts searching as soon as typing, without enter needed
o.ignorecase     = true -- ignore letter case when searching
o.smartcase      = true -- case insentive unless capitals used in search
o.hlsearch       = true -- hihlight all words

o.matchtime      = 2    -- delay before showing matching paren
o.mps            = o.mps .. ",<:>"

-- White characters
o.autoindent     = true
o.autoread       = true
o.smartindent    = true
o.tabstop        = 2    -- 1 tab = 2 spaces
o.shiftwidth     = 2    -- indentation rule
-- o.formatoptions = 'qnj1' -- q  - comment formatting; n - numbered lists; j - remove comment when joining lines; 1 - don't break after one-letter word
o.expandtab      = true -- expand tab to spaces

-- Backup files
o.backup         = false -- use backup files
o.writebackup    = false
-- o.swapfile = false -- do not use swap file
-- o.undodir = HOME .. '/.vim/tmp/undo//' -- undo files
-- o.backupdir = HOME .. '/.vim/tmp/backup//' -- backups
-- o.directory = '/.vim/tmp/swap//' -- swap files

vim.cmd([[
  au FileType python                  set ts=2 sw=2
  au BufRead,BufNewFile *.md          set ft=mkd tw=80 syntax=markdown
  au BufRead,BufNewFile *.mdx         set ft=mkd tw=80 syntax=markdown
  au BufRead,BufNewFile *.markdown    set ft=mkd tw=80 syntax=markdown
  au BufRead,BufNewFile *.slimbars    set syntax=slim
]])

-- Commands mode
o.wildmenu = true -- on TAB, complete options for system command
o.wildignore =
'deps,.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,.DS_Store,*.aux,*.out,*.toc,bundle,cdk.out,build,dist,Library,node_modules,__pycache__,Debug,Android,ios,bower_components,*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js,*.prefab,*.meta,*.unity,*.asset,*.mp4,*.mp3,*.avi,*.mov,*.fbx,*.pdf,*.maya,*.blender,*.user,*.dwlt,*.db,*.pref'

-- Only show cursorline in the current window and in normal mode.
vim.cmd([[
  augroup cline
      au!
      au WinLeave * set nocursorline
      au WinEnter * set cursorline
      au InsertEnter * set nocursorline
      au InsertLeave * set cursorline
  augroup END
]])

-- o.background = 'dark'
-- vim.cmd('colorscheme Tomorrow-Night')
--g.material_style = "palenight"

g.python3_host_prog = "/Users/gautamnaik/anaconda3/bin/python"
g.python_host_prog = "/Users/gautamnaik/anaconda3/bin/python"

-- o.showtabline = 2

-- vim.cmd [[autocmd BufWritePre <buffer> Format()]]
-- or
-- vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
