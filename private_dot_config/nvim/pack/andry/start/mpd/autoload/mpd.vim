function! mpd#complete(A, L, P)
    return sort(luaeval("require('mpd'):_get_operations()"))
endfunction

function! mpd#main()
    lua require('mpd'):status()
endfunction

function! mpd#main(command)
    call luaeval("require('mpd'):_exec_command(_A)", a:command)
endfunction
