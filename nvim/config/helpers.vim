" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

function! s:get_visual_selection()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    echo lines
    return join(lines, "\n")
endfunction

function! JSXComment()
    ":execute "normal! $"
    ":execute "startinsert! {/* \stopinsert"
endfunction
" Rename current file
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>rf :call RenameFile()<cr>

command -nargs=+ Se execute 'vimgrep /' . [<f-args>][0] . '/ **/*.' . [<f-args>][1]

" Compare current buffer with the actual (saved) file on disk
function! s:DiffWithSaved()
  let l:filetype = &filetype
  diffthis
  vnew | read # | normal! ggdd
  diffthis
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile readonly nomodifiable
  let &filetype = l:filetype
endfunction
command DiffWithSaved call s:DiffWithSaved()

" Reveal {{{
" Reveal file in the system file explorer
function! s:Reveal(path)
  if has('macunix')
    " only macOS has functionality to really 'reveal' a file, that is, to open
    " its parent directory in Finder and select this file
    call system('open -R ' . fnamemodify(a:path, ':S'))
  else
    " for other systems let's not reinvent the bicycle, instead we open file's
    " parent directory using netrw's builtin function (don't worry, netrw is
    " always bundled with Nvim)
    call s:Open(a:path)
  endif
endfunction
command Reveal call s:Reveal(expand('%'))
" }}}

" Open {{{
" opens file with a system program
function! s:Open(path)
	" HACK: 2nd parameter of this function is called 'remote', it tells
	" whether to open a remote (1) or local (0) file. However, it doesn't work
	" as expected in this context, because it uses the 'gf' command if it's
	" opening a local file (because this function was designed to be called
	" from the 'gx' command). BUT, because this function only compares the
	" value of the 'remote' parameter to 1, I can pass any other value, which
	" will tell it to open a local file and ALSO this will ignore an
	" if-statement which contains the 'gf' command.
	call netrw#BrowseX(a:path, 2)
endfunction
command Open call s:Open(expand('%'))
" }}}

" }}}


" function! Tabbufn()
" let s:tab_count = tabpagenr('$')
" if s:tab_count <= 1 :bn
" else :tabnext
" endif
" endfunction
" function! Tabbufp()
" let s:tab_count = tabpagenr('$')
" if s:tab_count <= 1 :bp
" else :tabprev
" endif
" endfunction
" nnoremap <silent> <Leader>[ :call Tabbufp()<CR>
" nnoremap <silent> <Leader>] :call Tabbufn()<CR>

":g/^$/d
command! DeleteEmptyLines execute "normal! :g/^$/d<cr>"

command! SmartDeleteEmptyLines execute "normal! :g/^$/,/./-j<cr>"
"https://stackoverflow.com/questions/3032030/how-does-g-j-reduce-multiple-blank-lines-to-a-single-blank-work-in-vi
"https://vim.fandom.com/wiki/Remove_unwanted_empty_lines"

"Following function will find /date word and append current date to it.
"This function is very specific for my blog .md files 
function! s:UpdatePubDate()
    execute "normal mz"
    execute "normal gg"
    execute "/date"
    execute "normal f'di'"
    execute ":pu=strftime('%Y-%m-%d')"
    execute "normal kJF'x$pF x"
    execute "normal `z"
    "execute ":s/^M//ge"
    "execute "?\s"
    "execute "normal x"
    "execute 'normal "=strftime('%Y-%m-%d ')'
    "execute 'normal "=P'
endfunction

"command! UpdateDate execute "normal gg/date<cr>f'di':pu=strftime('%Y-%m-%d ')<cr>"
command! UpdatePubDate call s:UpdatePubDate()

"Following function will find /updateDate word and append current date to it.
"This function is very specific for my blog .md files 
function! s:UpdateUpDate()
    execute "normal mz"
    execute "normal gg"
    execute "/updatedDate"
    execute "normal f'di'"
    execute ":pu=strftime('%Y-%m-%d')"
    execute "normal kJF'x$pF x"
    execute "normal `z"
endfunction

command! UpdateUpDate call s:UpdateUpDate()

function! TwiddleCase(str)
  if a:str ==# toupper(a:str)
    let result = tolower(a:str)
  elseif a:str ==# tolower(a:str)
    let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
  else
    let result = toupper(a:str)
  endif
  return result
endfunction
vnoremap ~ y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgv


" lua vim.api.nvim_command [[autocmd CursorHold   * lua require'utils'.blameVirtText()]]
" lua vim.api.nvim_command [[autocmd CursorMoved  * lua require'utils'.clearBlameVirtText()]]
" lua vim.api.nvim_command [[autocmd CursorMovedI * lua require'utils'.clearBlameVirtText()]]

" hi! link GitLens Comment