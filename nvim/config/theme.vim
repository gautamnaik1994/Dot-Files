
"colorscheme gruvbox

"set background=dark " for the dark version
"colorscheme OceanicNext

let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_improved_strings = 1
let g:gruvbox_invert_indent_guides=1
let g:gruvbox_italicize_strings = 1
let g:gruvbox_improved_warnings = 1
" let g:oceanic_next_terminal_bold = 1
" let g:oceanic_next_terminal_italic = 1"

"colorscheme space-vim-dark"
"let g:space_vim_dark_background = 233
"color space-vim-dark"

"colorscheme one
"set background=dark " for the dark version
let g:one_allow_italics = 1 "
"  let g:onedark_color_overrides = {
"  \ "black": {"gui": "#262626", "cterm": "235", "cterm16": "0" }
"  \}

let g:onedark_terminal_italics=1

"colorscheme onedark
set background=dark



"colorscheme PaperColor

" highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
" highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
" highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
" highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
if &diff
    highlight! link DiffText MatchParen
endif


" hi MatchParen ctermfg=yellow guifg=yellow cterm=bold gui=bold guibg=none ctermbg=none
highlight SignColumn ctermbg=none guibg=none

set fillchars+=vert:│

highlight VertSplit ctermbg=none guibg=none
" Pmenu – normal item
" PmenuSel – selected item
" PmenuSbar – scrollbar
" PmenuThumb – thumb of the scrollbar
highlight Pmenu ctermbg=gray ctermfg=gray guibg=gray
"highlight PmenuSel ctermbg=gray ctermfg=gray


