

"""""""""""""""""""""""""""""""""Airline""""""""""""""""""""""""""""""""""""""""""""
"let g:airline_theme='base16_spacemacs'
let g:airline_theme='random'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 2
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#ale#enabled = 1
let g:airline_detect_paste=1

"let g:airline_left_sep = "\uE0C0"

if exists("g:gui_oni")
    " if !exists('g:airline_symbols')
    "     let g:airline_symbols = {}
    " endif
    " " unicode symbols
    " let g:airline_left_sep = ''
    " let g:airline_left_sep = ''
    " let g:airline_right_sep = ''
    " let g:airline_right_sep = ''
    " let g:airline_symbols.crypt = ''
    " let g:airline_symbols.linenr = ''
    " let g:airline_symbols.linenr = ''
    " let g:airline_symbols.linenr = ''
    " let g:airline_symbols.linenr = ''
    " let g:airline_symbols.maxlinenr = ''
    " let g:airline_symbols.maxlinenr = ''
    " let g:airline_symbols.branch = ''
    " let g:airline_symbols.paste = ''
    " let g:airline_symbols.paste = ''
    " let g:airline_symbols.paste = ''
    " let g:airline_symbols.spell = ''
    " let g:airline_symbols.notexists = ''
    " let g:airline_symbols.whitespace = ''
    " powerline symbols

else
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif
    let g:airline_powerline_fonts = 1
    let g:airline_symbols.branch = 'שׂ'
    let g:airline_symbols.readonly = ''
    let g:airline_symbols.linenr = ''
    let g:airline_symbols.whitespace = ''
    " let g:airline_left_sep = '»'
    " let g:airline_left_sep = '▶'
    " let g:airline_right_sep = '«'
    " let g:airline_right_sep = '◀'
    " let g:airline_symbols.crypt = '🔒'
    " let g:airline_symbols.linenr = '☰'
    " let g:airline_symbols.linenr = '␊'
    " let g:airline_symbols.linenr = '␤'
    " let g:airline_symbols.linenr = '¶'
    " let g:airline_symbols.maxlinenr = ''
    " let g:airline_symbols.maxlinenr = '㏑'
    " let g:airline_symbols.paste = 'ρ'
    " let g:airline_symbols.paste = 'Þ'
    " let g:airline_symbols.paste = '∥'
    " let g:airline_symbols.spell = 'Ꞩ'
    " let g:airline_symbols.notexists = '∄'

    " let g:airline_left_sep = ''
    " let g:airline_left_alt_sep = ''
    " let g:airline_right_sep = ''
    " let g:airline_right_alt_sep = ''

    " let g:airline_symbols.maxlinenr = ''
endif


