
set completeopt=longest,menuone,preview

let b:switch_custom_definitions =
    \ [
    \   [  '+=' , '-='  ],
    \   [  'private' , 'public', 'protected'  ],
    \   [  'struct' , 'class'  ],
    \   [  'OnDisable()' , 'OnEnable()' ],
    \   [  'Update()' , 'FixedUpdate()' ],
    \   [  'Debug.Log(' , 'Debug.LogFormat('],
    \   [  'Debug.LogError(', 'Debug.LogErrorFormat(' ],
    \   [  'Debug.LogWarning(', 'Debug.LogWarningFormat(' ]
\ ]
set errorformat=\ %#%f(%l\\\,%c):\ error\ CS%n:\ %m




nnoremap <leader>cd :OmniSharpGotoDefinition<cr>

    " Add syntax highlighting for types and interfaces
    nnoremap <Leader>th :OmniSharpHighlightTypes<CR>

    nnoremap <Leader>cf :OmniSharpCodeFormat<CR>

    " Rename with dialog
    nnoremap <Leader>nm :OmniSharpRename<CR>
    nnoremap <F2> :OmniSharpRename<CR>
    " Rename without dialog - with cursor on the symbol to rename: `:Rename newname`
    command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")


" Omnisharp mappings
augroup omnisharp_commands
    autocmd!
    " Synchronous build (blocks Vim)
    "autocmd FileType cs nnoremap <F5> :wa!<cr>:OmniSharpBuild<cr>
    " Builds can also run asynchronously with vim-dispatch installed
    " automatic syntax check on events (TextChanged requires Vim 7.4)
    "autocmd BufEnter,TextChanged,InsertLeave *.cs Neomake

    " Automatically add new cs files to the nearest project on save
    "autocmd BufWritePost *.cs call OmniSharp#AddToProject()
    autocmd BufWritePost <buffer> call OmniSharp#AddToProject()

    autocmd BufWritePre <buffer> OmniSharpCodeFormat

    autocmd BufEnter,TextChanged,InsertLeave <buffer> SyntasticCheck

    "show type information automatically when the cursor stops moving
    autocmd CursorHold <buffer> call OmniSharp#TypeLookupWithoutDocumentation()

    "The following commands are contextual, based on the current cursor position.

"    autocmd FileType cs nnoremap <leader>mb :wa!<cr>:OmniSharpBuildAsync<cr>
    " autocmd FileType cs nnoremap <leader>mg :OmniSharpGotoDefinition<cr>
    " autocmd FileType cs nnoremap <leader>mt :OmniSharpTypeLookup<cr>
    " autocmd FileType cs nnoremap <leader>mr :OmniSharpRename<CR>
    " autocmd FileType cs nnoremap <leader>mc :OmniSharpCodeFormat<CR>
    " autocmd FileType cs nnoremap <leader>md :OmniSharpDocumentation<cr>
    " autocmd FileType cs nnoremap <leader>mfi :OmniSharpFindImplementations<cr>
    " autocmd FileType cs nnoremap <leader>mft :OmniSharpFindType<cr>
    " autocmd FileType cs nnoremap <leader>mfs :OmniSharpFindSymbol<cr>
    " autocmd FileType cs nnoremap <leader>mfu :OmniSharpFindUsages<cr>
    " autocmd FileType cs nnoremap <leader>mfm :OmniSharpFindMembers<cr>
    " autocmd FileType cs nnoremap <leader>mss :OmniSharpStartServer<cr>
    " autocmd FileType cs nnoremap <leader>msp :OmniSharpStopServer<cr>
    " autocmd FileType cs nnoremap <leader>mxi  :OmniSharpFixIssue<cr>
    " autocmd FileType cs nnoremap <leader>mxu :OmniSharpFixUsings<cr>

    " let g:mmap = {'name': 'OmniSharp'}
    " let g:mmap.b = ['OmniSharpBuildAsync', 'Build']
    " let g:mmap.g = ['OmniSharpGotoDefinition', 'Go to definition']
    " let g:mmap.t = ['OmniSharpTypeLookup', 'Lookup type']
    " let g:mmap.r = ['OmniSharpRename', 'Rename']
    " let g:mmap.c = ['OmniSharpCodeFormat', 'Code format']
    " let g:mmap.d = ['OmniSharpDocumentation', 'Documentation']
    " let g:mmap.f = {'name': 'Find'}
    " let g:mmap.f.i = ['OmniSharpFindImplementations', 'Implementation']
    " let g:mmap.f.t = ['OmniSharpFindType', 'Type']
    " let g:mmap.f.s = ['OmniSharpFindSymbol', 'Symbol']
    " let g:mmap.f.u = ['OmniSharpFindUsages', 'Usages']
    " let g:mmap.f.m = ['OmniSharpFindMembers', 'Members']
    " let g:mmap.s = {'name': 'Server'}
    " let g:mmap.s.s = [':OmniSharpStartServer', 'Start']
    " let g:mmap.s.p = [':OmniSharpStopServer', 'Stop']
    " let g:mmap.x = {'name': 'Fix'}
    " let g:mmap.x.i = [':OmniSharpFixIssue', 'Issue']
    " let g:mmap.x.u = [':OmniSharpFixUsings', 'Usings']

    "autocmd FileType cs let g:lmap['m'] = g:mmap

    "navigate up by method/property/field
    "autocmd FileType cs nnoremap <C-K> :OmniSharpNavigateUp<cr>
    "navigate down by method/property/field
    "autocmd FileType cs nnoremap <C-J> :OmniSharpNavigateDown<cr>



augroup END


"Code Actions Available flag

 set updatetime=500

sign define OmniSharpCodeActions text=💡

augroup OSCountCodeActions
  autocmd!
  autocmd FileType cs set signcolumn=yes
  autocmd CursorHold *.cs call OSCountCodeActions()
augroup END

function! OSCountCodeActions() abort
  if OmniSharp#CountCodeActions({-> execute('sign unplace 99')})
    let l = getpos('.')[1]
    let f = expand('%:p')
    execute ':sign place 99 line='.l.' name=OmniSharpCodeActions file='.f
  endif
endfunction
