function! s:split(...) abort
    let direction = a:1
    let file = exists('a:2') ? a:2 : ''
    call VSCodeCall(direction ==# 'h' ? 'workbench.action.splitEditorDown' : 'workbench.action.splitEditorRight')
    if !empty(file)
        call VSCodeExtensionNotify('open-file', expand(file), 'all')
    endif
endfunction

function! s:splitNew(...)
    let file = a:2
    call s:split(a:1, file == '' ? '__vscode_new__' : file)
endfunction

function! s:closeOtherEditors()
    call VSCodeNotify('workbench.action.closeEditorsInOtherGroups')
    call VSCodeNotify('workbench.action.closeOtherEditors')
endfunction

function! s:manageEditorSize(...)
    let count = a:1
    let to = a:2
    for i in range(1, count ? count : 1)
        call VSCodeNotify(to == 'increase' ? 'workbench.action.increaseViewSize' : 'workbench.action.decreaseViewSize')
    endfor
endfunction

function! s:switchEditor(...) abort
    let count = a:1
    let direction = a:2
    for i in range(1, count ? count : 1)
        call VSCodeCall(direction ==# 'next' ? 'workbench.action.nextEditorInGroup' : 'workbench.action.previousEditorInGroup')
    endfor
endfunction

command! -complete=file -nargs=? Split call <SID>split('h', <q-args>)
command! -complete=file -nargs=? Vsplit call <SID>split('v', <q-args>)
command! -complete=file -nargs=? New call <SID>split('h', '__vscode_new__')
command! -complete=file -nargs=? Vnew call <SID>split('v', '__vscode_new__')
command! -bang Only if <q-bang> == '!' | call <SID>closeOtherEditors() | else | call VSCodeNotify('workbench.action.joinAllGroups') | endif

nnoremap <silent> <C-w>s :call <SID>split('h')<CR>
xnoremap <silent> <C-w>s :call <SID>split('h')<CR>

nnoremap <silent> <C-w>v :call <SID>split('v')<CR>
xnoremap <silent> <C-w>v :call <SID>split('v')<CR>

nnoremap <silent> <C-w>n :call <SID>splitNew('h', '__vscode_new__')<CR>
xnoremap <silent> <C-w>n :call <SID>splitNew('h', '__vscode_new__')<CR>

nnoremap <silent> <C-w>= :<C-u>call VSCodeNotify('workbench.action.evenEditorWidths')<CR>
xnoremap <silent> <C-w>= :<C-u>call VSCodeNotify('workbench.action.evenEditorWidths')<CR>
nnoremap <silent> <C-w>_ :<C-u>call VSCodeNotify('workbench.action.toggleEditorWidths')<CR>

nnoremap <silent> <C-w>> :<C-u>call <SID>manageEditorSize(v:count, 'increase')<CR>
xnoremap <silent> <C-w>> :<C-u>call <SID>manageEditorSize(v:count, 'increase')<CR>
nnoremap <silent> <C-w>+ :<C-u>call <SID>manageEditorSize(v:count, 'increase')<CR>
xnoremap <silent> <C-w>+ :<C-u>call <SID>manageEditorSize(v:count, 'increase')<CR>
nnoremap <silent> <C-w>< :<C-u>call <SID>manageEditorSize(v:count, 'decrease')<CR>
xnoremap <silent> <C-w>< :<C-u>call <SID>manageEditorSize(v:count, 'decrease')<CR>
nnoremap <silent> <C-w>- :<C-u>call <SID>manageEditorSize(v:count, 'decrease')<CR>
xnoremap <silent> <C-w>- :<C-u>call <SID>manageEditorSize(v:count, 'decrease')<CR>

" Better Navigation
nnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
xnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
nnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
xnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
nnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
xnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
nnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>
xnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>

" Tap Navigation
nnoremap <silent> L :call <SID>switchEditor(v:count, 'next')<CR>
xnoremap <silent> L :call <SID>switchEditor(v:count, 'next')<CR>
nnoremap <silent> H :call <SID>switchEditor(v:count, 'prev')<CR>
xnoremap <silent> H :call <SID>switchEditor(v:count, 'prev')<CR>

" Folding
nnoremap <silent> za <Cmd>call VSCodeNotify('editor.toggleFold')<CR>
nnoremap <silent> zR <Cmd>call VSCodeNotify('editor.unfoldAll')<CR>
nnoremap <silent> zM <Cmd>call VSCodeNotify('editor.foldAll')<CR>
nnoremap <silent> zo <Cmd>call VSCodeNotify('editor.unfold')<CR>
nnoremap <silent> zO <Cmd>call VSCodeNotify('editor.unfoldRecursively')<CR>
nnoremap <silent> zc <Cmd>call VSCodeNotify('editor.fold')<CR>
nnoremap <silent> zC <Cmd>call VSCodeNotify('editor.foldRecursively')<CR>
nnoremap <silent> z1 <Cmd>call VSCodeNotify('editor.foldLevel1')<CR>
nnoremap <silent> z2 <Cmd>call VSCodeNotify('editor.foldLevel2')<CR>
nnoremap <silent> z3 <Cmd>call VSCodeNotify('editor.foldLevel3')<CR>
nnoremap <silent> z4 <Cmd>call VSCodeNotify('editor.foldLevel4')<CR>
nnoremap <silent> z5 <Cmd>call VSCodeNotify('editor.foldLevel5')<CR>
nnoremap <silent> z6 <Cmd>call VSCodeNotify('editor.foldLevel6')<CR>
nnoremap <silent> z7 <Cmd>call VSCodeNotify('editor.foldLevel7')<CR>
xnoremap <silent> zV <Cmd>call VSCodeNotify('editor.foldAllExcept')<CR>

function! MoveCursor(direction) abort
    if(reg_recording() == '' && reg_executing() == '')
        return 'g'.a:direction
    else
        return a:direction
    endif
endfunction

nnoremap <expr> j MoveCursor('j')
nnoremap <expr> k MoveCursor('k')

" Whichkey
nnoremap <silent> <Space> :call VSCodeNotify('whichkey.show')<CR>
xnoremap <silent> <Space> :call VSCodeNotify('whichkey.show')<CR>
