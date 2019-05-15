
"   ______    ______   __    __  ________  ______   __       __        __    __   ______   ______  __    __
"  /      \  /      \ /  |  /  |/        |/      \ /  \     /  |      /  \  /  | /      \ /      |/  |  /  |
" /$$$$$$  |/$$$$$$  |$$ |  $$ |$$$$$$$$//$$$$$$  |$$  \   /$$ |      $$  \ $$ |/$$$$$$  |$$$$$$/ $$ | /$$/
" $$ | _$$/ $$ |__$$ |$$ |  $$ |   $$ |  $$ |__$$ |$$$  \ /$$$ |      $$$  \$$ |$$ |__$$ |  $$ |  $$ |/$$/
" $$ |/    |$$    $$ |$$ |  $$ |   $$ |  $$    $$ |$$$$  /$$$$ |      $$$$  $$ |$$    $$ |  $$ |  $$  $$<
" $$ |$$$$ |$$$$$$$$ |$$ |  $$ |   $$ |  $$$$$$$$ |$$ $$ $$/$$ |      $$ $$ $$ |$$$$$$$$ |  $$ |  $$$$$  \
" $$ \__$$ |$$ |  $$ |$$ \__$$ |   $$ |  $$ |  $$ |$$ |$$$/ $$ |      $$ |$$$$ |$$ |  $$ | _$$ |_ $$ |$$  \
" $$    $$/ $$ |  $$ |$$    $$/    $$ |  $$ |  $$ |$$ | $/  $$ |      $$ | $$$ |$$ |  $$ |/ $$   |$$ | $$  |
"  $$$$$$/  $$/   $$/  $$$$$$/     $$/   $$/   $$/ $$/      $$/       $$/   $$/ $$/   $$/ $$$$$$/ $$/   $$/



if empty(glob('~/AppData/Local/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/AppData/Local/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/AppData/Local/nvim/bundle')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Autocompletion and Sources
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Plug 'fszymanski/deoplete-emoji'
"Plug 'gautamnaik1994/deoplete-omnisharp'
"Plug 'Shougo/neco-vim'
"Plug 'Valloric/YouCompleteMe'
"Plug 'carlitux/deoplete-ternjs', {'do': 'npm install -g tern', 'for': ['javascript', 'javascript.jsx'] }
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'tbodt/deoplete-tabnine', { 'do': 'powershell.exe .\install.ps1' }
"Plug 'deoplete-plugins/deoplete-jedi',{ 'for': [ 'python'] }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Language Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Plug 'beyondmarc/hlsl.vim'
"Plug 'tikhomirov/vim-glsl'
"Plug 'vim-scripts/cg.vim'
"Plug 'chemzqm/vim-jsx-improve'
"Plug 'larsbs/vim-xmll'                                            " Tweaked Vim XML syntax highlighting plugin - React close tags look a little nicer with this!
"Plug 'neoclide/vim-jsx-improve'
"Plug 'othree/es.next.syntax.vim'
"Plug 'othree/html5.vim'
"Plug 'othree/yajs.vim'
Plug 'gautamnaik1994/ShaderHighLight'
Plug 'moll/vim-node', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
"Plug 'nvie/vim-flake8',{ 'for': [ 'python'] }
Plug 'OmniSharp/omnisharp-vim',{'for':['cs']}
Plug 'OrangeT/vim-csharp',{'for':['cs']}
"Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/xml.vim'
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'posva/vim-vue',{ 'for': ['vue'] }
"Plug 'ternjs/tern_for_vim', {'for': ['javascript', 'javascript.jsx'], 'do': 'npm install' }
"Plug 'vim-python/python-syntax'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Interface
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'chrisbra/NrrwRgn'
Plug 'kien/rainbow_parentheses.vim'
"Plug 'machakann/vim-highlightedyank'
"Plug 'majutsushi/tagbar'
Plug 'mhinz/vim-signify'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'Yggdroot/indentLine'
Plug 'vim-scripts/indentpython.vim',{ 'for': [ 'python'] }
Plug 'ncm2/float-preview.nvim'
Plug 'liuchengxu/vista.vim'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Utilities
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Plug 'justinmk/vim-sneak'
"Plug 'matze/vim-move'
"Plug 'Shougo/denite.nvim'
"Plug 'townk/vim-autoclose'
"Plug 'tpope/vim-sensible'
"Plug 'vim-scripts/taglist.vim'
"Plug 'vim-syntastic/syntastic', {'for':['cs']}
Plug 'airblade/vim-rooter'
Plug 'andymass/vim-matchup'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'editorconfig/editorconfig-vim'
"Plug 'ervandew/supertab'
Plug 'honza/vim-snippets'
Plug 'jlanzarotta/bufexplorer'
Plug 'mattn/emmet-vim'
Plug 'mbbill/undotree'
Plug 'mileszs/ack.vim' "Install ack(choco install ack) and ag(choco install ag)
Plug 'myusuf3/numbers.vim'
"Plug 'prettier/vim-prettier', {'do': 'npm install','for': ['javascript', 'css', 'scss', 'json','vue']}
Plug 'qwertologe/nextval.vim'
Plug 'Raimondi/delimitMate'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'SirVer/ultisnips'
Plug 'tmhedberg/SimpylFold',{ 'for': [ 'python'] }
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
"Plug 'vim-scripts/cream-capitalization'
Plug 'vim-scripts/indentpython.vim',{ 'for': [ 'python'] }
"Plug 'w0rp/ale',{ 'for': ['javascript', 'javascript.jsx', 'python','cs'] }
Plug 'wellle/targets.vim'
Plug 'meain/vim-package-info', { 'do': 'npm install' }
Plug 'yuttie/comfortable-motion.vim'
Plug 'rhysd/git-messenger.vim'
Plug 'Shougo/echodoc.vim'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Themeing
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Plug 'gautamnaik1994/oceanic-next'
"Plug 'liuchengxu/space-vim-dark'
"Plug 'mhartington/oceanic-next'"
"Plug 'morhetz/gruvbox'
"Plug 'NLKNguyen/papercolor-theme'
Plug 'equalsraf/neovim-gui-shim'
Plug 'joshdick/onedark.vim'
Plug 'rakr/vim-one'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline-themes'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => COC plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Plug 'neoclide/coc.nvim', {'do': './install.sh nightly'}
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
"Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}
"Plug 'neoclide/coc-sources', {'do': 'yarn install --frozen-lockfile'}
"Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
"Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}
"Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
"Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
"Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}
"Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
"Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}

call plug#end()


"Source files from config folder
for f in split(glob('~/AppData/Local/nvim/config/*.vim'), '\n')
    exe 'source' f
endfor

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Miscellaneous
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if (has("termguicolors"))
    set termguicolors
endif

"au BufRead,BufNewFile syn region xmlTagName matchgroup=xmlTag start=+</+ end=+>+
syn region xmlTagName matchgroup=xmlTag start=+</+ end=+>+
let python_highlight_all=1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Autocommands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup generalAutoCommand
    autocmd!
augroup END

"augroup autosourcing
"autocmd!
"autocmd BufWritePost init.vim source %  "Automatically source file vimrc file
"augroup END
"Create and write file to hdd
autocmd generalAutoCommand BufNewFile * :write
autocmd generalAutoCommand BufWritePost init.vim source %  "Automatically source file vimrc file

" Automatically clean trailing whitespace
autocmd generalAutoCommand BufWritePre * :%s/\s\+$//e
"autocmd generalAutoCommand BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

autocmd generalAutoCommand BufNewFile,BufRead *.scss set ft=scss.css

autocmd generalAutoCommand Filetype json let g:indentLine_setConceal = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Omnifuncs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup omnifuncs
    autocmd!
    autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType scss setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType sass setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    "autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd FileType json syntax match Comment +\/\/.\+$+
augroup end


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => rainbow_parentheses.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has_key(g:plugs, 'rainbow_parentheses.vim')
    augroup rainboweparens
        autocmd!
        au VimEnter * RainbowParenthesesToggle
        au Syntax * RainbowParenthesesLoadRound
        au Syntax * RainbowParenthesesLoadSquare
        au Syntax * RainbowParenthesesLoadBraces
    augroup end
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-jsx
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:jsx_ext_required = 0
"highlight link xmlEndTag xmlTag
"hi link xmlEndTag xmlTag"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => indentLine
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:indentLine_char = '│'
let g:vim_json_syntax_conceal = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => deoplete.nvim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has_key(g:plugs, 'deoplete.nvim')
    let g:deoplete#enable_at_startup = 1
    " Autocomplete from files now works from current buffer
    let g:deoplete#file#enable_buffer_path = 1

    let g:deoplete#enable_smart_case = 1
    let g:deoplete#enable_ignore_case = 1
    let g:deoplete#enable_camel_case = 1
    "call deoplete#enable_logging('DEBUG', 'deoplete.log')
    let g:deoplete#enable_profile = 1
    "call deoplete#enable_logging('DEBUG', 'deoplete.log')
    "call deoplete#custom#source('cs', 'debug_enabled', 1)
     call deoplete#custom#option('sources', {
    \ 'cs': ['omnisharp'],
    \ })

endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => deoplete-ternjs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has_key(g:plugs, 'deoplete-ternjs')
    if !exists('g:deoplete#omni#input_patterns')
        let g:deoplete#omni#input_patterns = {}
    endif
    let g:deoplete#omni#functions = {}
    let g:deoplete#sources = {}
    let g:deoplete#sources['javascript'] = ['file', 'ultisnips', 'tern', 'buffer']
    let g:deoplete#sources['javascript.jsx'] = ['file', 'ultisnips', 'tern', 'buffer']
    autocmd generalAutoCommand FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>
    autocmd generalAutoCommand FileType javascript.jsx nnoremap <silent> <buffer> gb :TernDef<CR>
    " Whether to include the types of the completions in the result data. Default: 0
    let g:deoplete#sources#ternjs#types = 1
    " Whether to include the distance (in scopes for variables, in prototypes for
    " properties) between the completions and the origin position in the result
    " data. Default: 0
    let g:deoplete#sources#ternjs#depths = 1
    " Whether to include documentation strings (if found) in the result data.
    " Default: 0
    let g:deoplete#sources#ternjs#docs = 1
    " Whether to include JavaScript keywords when completing something that is not
    " a property. Default: 0
    let g:deoplete#sources#ternjs#include_keywords = 1
    " Whether to use a case-insensitive compare between the current word and
    " potential completions. Default 0
    let g:deoplete#sources#ternjs#case_insensitive = 1

endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => tern_for_vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has_key(g:plugs, 'tern_for_vim')
    let g:tern_request_timeout = 1
    let g:tern_show_signature_in_pum = 1
    let g:tern#command = ["tern"]
    let g:tern#arguments = ["--persistent"]
    let g:tern#arguments = [" — persistent"]
    let g:tern_show_argument_hints = 'on_hold'
    autocmd generalAutoCommand FileType javascript set omnifunc=tern#Complete
    autocmd generalAutoCommand FileType javascript.jsx set omnifunc=tern#Complete
    " Helpful commands from the docs
    nnoremap <Leader>td :TernDoc<CR>
    nnoremap <Leader>tb :TernDocBrowse<CR>
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ultisnips
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has_key(g:plugs, 'ultisnips')
    let g:UltiSnipsEditSplit="vertical"
    "autocmd generalAutoCommand FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
    let g:UltiSnipsExpandTrigger="<C-j>"
    "inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    let g:UltiSnipsSnippetDirectories = ['~/AppData/Local/nvim/UltiSnips', 'UltiSnips']
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => nerdtree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup nerd
    autocmd!
    autocmd vimenter * NERDTree
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
    autocmd VimEnter *
                \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
                \|   PlugInstall --sync | q
                \| endif
augroup end
map <C-n> :NERDTreeToggle<CR>
let NERDTreeMinimalUI=1
"let g:NERDTreeDirArrowExpandable = '▸'⯈
let g:NERDTreeDirArrowExpandable = '⯈'
"let g:NERDTreeDirArrowCollapsible = '▾'⯆
let g:NERDTreeDirArrowCollapsible = '⯆'
let NERDTreeIgnore = ['\.meta$','\.asset$','\.csproj$','\.cache$','\.apk$']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => emmet-vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:user_emmet_leader_key='<C-Z>'
let g:user_emmet_mode='a'    "enable all function in all mode.
let g:user_emmet_settings = {
            \  'javascript.jsx' : {
            \      'extends' : 'jsx',
            \  },
            \}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-prettier
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has_key(g:plugs, 'vim-prettier')
" let g:prettier#exec_cmd_path = "~/AppData/Local/nvim/bundle/vim-prettier/node_modules/.bin/prettier"
" let g:prettier#config#print_width = 80
 "let g:prettier#config#tab_width = 2
" let g:prettier#config#use_tabs = 'true'
" let g:prettier#config#semi = 'true'
" let g:prettier#config#single_quote = 'true'
" " print spaces between brackets
" " Prettier default: true
" let g:prettier#config#bracket_spacing = 'true'
" " put > on the last line instead of new line
" " Prettier default: false
" let g:prettier#config#jsx_bracket_same_line = 'false'
" " avoid|always
" " Prettier default: avoid
" let g:prettier#config#arrow_parens = 'always'
" " none|es5|all
" " Prettier default: none
" let g:prettier#config#trailing_comma = 'all'
" " let g:prettier#autoformat = 0
" let g:prettier#exec_cmd_async = 1
" let g:prettier#config#parser = 'babylon'
let g:prettier#autoformat = 0
autocmd generalAutoCommand BufWritePre *.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync
"autocmd generalAutoCommand BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ale
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has_key(g:plugs, 'ale')
    "let g:ale_sign_error = '●' " Less aggressive than the default '>>'
    "let g:ale_sign_warning = '--'
    " let g:ale_sign_error = '❌'
    " let g:ale_sign_warning = '⚠️'
    " Use a slightly slimmer error pointer
    "let g:ale_sign_error = '✖'
    "hi ALEErrorSign guifg=#DF8C8C
    "let g:ale_sign_warning = '⚠'
    "hi ALEWarningSign guifg=#F2C38F
    "let g:ale_sign_error = '×'
    let g:ale_linters = {
    \ 'cs': ['OmniSharp'],
    \ 'javascript': ['eslint']
    \}
    " let g:ale_linters = {'javascript': ['eslint']}
    let g:ale_lint_on_enter = 0 " Less distracting when opening a new file
    let g:ale_emit_conflict_warnings = 0
    let g:ale_set_highlights = 0
    let g:ale_fix_on_save = 1
    let g:ale_javascript_prettier_use_local_config = 1
    let g:ale_fixers = {}
    let g:ale_fixers = {
                \   'javascript': ['prettier','eslint'],
                \   'python': ['autopep8']
                \ }
    let g:ale_python_autopep8_options = '--aggressive'
    "let g:ale_fixers['javascript.jsx'] = ['prettier_eslint']"
endif



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => CtrlP
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:ctrlp_custom_ignore = 'node_modules\DS_Store\|git'
"let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|\.meta$\|\.asset$\|\.cache$\|\.mat$'
"let g:ctrlp_cmd='CtrlP :pwd'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => SimpylFold
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:SimpylFold_docstring_preview=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => delimitMate
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" delimitMate fixes
imap <M-Left> <Plug>delimitMateC-Left
imap <M-Right> <Plug>delimitMateC-Right
imap <D-Left> <Plug>delimitMateHome
imap <D-Right> <Plug>delimitMateEnd

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => syntastic
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" let g:syntastic_cs_checkers = ['code_checker']
" let g:syntastic_warning_symbol = '--'
" let g:syntastic_error_symbol = '●'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-signify
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:signify_vcs_list = [ 'git' ]

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ack.Vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => omnisharp-vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has_key(g:plugs, 'omnisharp-vim')
let g:OmniSharp_server_path = 'C:\Neovim\omnisharp-roslyn\artifacts\publish\OmniSharp.Http.Driver\win7-x64\OmniSharp.exe'
let g:OmniSharp_server_type = 'roslyn'
let g:Omnisharp_stop_server = 2
if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif
"let g:deoplete#omni#input_patterns.cs = ['\.\w*']
let g:deoplete#omni#input_patterns.cs = ['\w+']
let g:deoplete#omni#functions = {}
let g:deoplete#sources = {}
let g:deoplete#sources.cs = ['omni', 'file', 'buffer', 'ultisnips','cs']
let g:OmniSharp_selector_ui = 'ctrlp'  " Use ctrlp.vim
let g:OmniSharp_use_random_port = 1
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Supertab
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has_key(g:plugs, 'supertab')
    "let g:SuperTabDefaultCompletionType = "<c-n>"
    let g:SuperTabDefaultCompletionType = 'context'
    let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
    let g:SuperTabDefaultCompletionTypeDiscovery = ["&omnifunc:<c-x><c-o>","&completefunc:<c-x><c-n>"]
    let g:SuperTabClosePreviewOnPopupClose = 1
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Number
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <F6> :NumbersToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NrrwRgn
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:nrrw_rgn_vert = 1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-matchup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" augroup matchup_matchparen_highlight
"   autocmd!
"   autocmd ColorScheme * hi MatchParen ctermfg=yellow guifg=yellow cterm=none gui=none
" augroup END
hi MatchParen ctermfg=yellow guifg=yellow cterm=bold gui=bold guibg=none ctermbg=none
highlight Comment cterm=italic gui=italic

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-node
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Want <C-w>f to open the file under the cursor in a new vertical split?
"<C-w>f by default opens it in a horizontal split. To have it open vertically, drop this in your vimrc:"
autocmd User Node
  \ if &filetype == "javascript" |
  \   nmap <buffer> <C-w>f <Plug>NodeVSplitGotoFile |
  \   nmap <buffer> <C-w><C-f> <Plug>NodeVSplitGotoFile |
  \ endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => easymotion
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap s <Plug>(easymotion-s2)
nmap t <Plug>(easymotion-t2)



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Floating preview
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:float_preview#docked = 0


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vista
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vista#renderer#enable_icon = 1
