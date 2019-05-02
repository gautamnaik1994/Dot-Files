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
