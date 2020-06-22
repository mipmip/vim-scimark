function! OpenInScim()
  let lineundercursor=getline('.')
  let curlinenumber = line('.')
  echom lineundercursor

  if lineundercursor=~?'|.*|$'

    while lineundercursor=~?'|.*|$'
      let curlinenumber = curlinenumber -1
      let lineundercursor=getline(curlinenumber)
    endwhile

    let lineundercursor=getline(curlinenumber+1)
    let g:scimarkTableTopLine = curlinenumber+1
    let fileLines = []

    while lineundercursor=~?'|.*|$'
      let curlinenumber = curlinenumber + 1
      let lineundercursor = getline(curlinenumber)
      call add(fileLines, lineundercursor)
    endwhile

    let g:scimarkTempFile = tempname() . '.md'
    let g:scimarkOpenerBuffer = bufnr("%")
    let g:scimarkOpenerFile = expand("%")
    let g:scimarkTableBottonLine = curlinenumber-1
    let g:scimarkOpenerWindow = winnr()

    if writefile(fileLines, g:scimarkTempFile)
      echomsg 'write error'
    else
      call term_start('/home/pim/cForks/sc-im/src/sc-im ' . g:scimarkTempFile, { 'exit_cb': function('g:ReadFromScim')})
    endif
  endif

endfunction

function! g:ReadFromScim(job,exit_code)
  exe g:scimarkOpenerWindow . "wincmd w | wincmd c"
  exe 'buffer! '. g:scimarkOpenerBuffer
  exe g:scimarkTableTopLine.','.g:scimarkTableBottonLine.'d'
  call cursor(g:scimarkTableTopLine-1,0)
  exe 'r '.g:scimarkTempFile
endfunction

command! ScimEdit :call OpenInScim()

