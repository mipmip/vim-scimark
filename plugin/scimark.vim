call scimark#initVariable("g:scimCommand", 'sc-im')

function! OpenInScim()
  let lineundercursor=getline('.')
  let curlinenumber = line('.')

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
      if has('nvim')
        exe 'split(:sp)'
        call termopen(g:scimCommand . ' ' . g:scimarkTempFile, { 'on_exit': 'g:ReadFromScimNeoVim', 'on_stdout': 'NeoVimStartInsert'})
      else
        call term_start(g:scimCommand . ' ' . g:scimarkTempFile, { 'exit_cb': function('g:ReadFromScimVim')})
      endif
    endif
  endif

endfunction

function! g:ReadFromScimVim(job,exit_code)
  call g:ReadFromScim()
endfunction

function! g:NeoVimStartInsert(job,data,event)
  exe 'startinsert'
endfunction
function! g:ReadFromScimNeoVim(job,data,event)
  call g:ReadFromScim()
endfunction

function! g:ReadFromScim()
  exe g:scimarkOpenerWindow . "wincmd w | wincmd c"
  exe 'buffer! '. g:scimarkOpenerBuffer
  exe g:scimarkTableTopLine.','.g:scimarkTableBottonLine.'d'
  call cursor(g:scimarkTableTopLine-1,0)
  exe 'r '.g:scimarkTempFile
endfunction

command! OpenInScim :call OpenInScim()
nmap <leader>sc :OpenInScim<CR>
