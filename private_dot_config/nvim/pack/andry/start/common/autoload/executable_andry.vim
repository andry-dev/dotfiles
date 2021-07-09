function! andry#set_executable_flag()
    execute "!git add -f %"
    execute "!git update-index --chmod=+x %"
    execute "!chmod +x %"
endfunction()

function! andry#set_default_theme()
    lua set_default_theme()
endfunction()

function! andry#set_pretty_theme()
    lua set_pretty_theme()
endfunction()

" People hate my setup, especially the lack of syntax highlight.
" This function just changes some visual stuff to a 'normal' scheme,
" waits for input and resets everything back.
function! andry#setup_for_screenshots()
    let saved_lang = v:lang
    let saved_spell = &spell

    "TSEnableAll highlight

    language en_US.UTF-8
    set nospell

    call andry#set_pretty_theme()

    redraw
    call getchar()

    "TSDisableAll highlight

    call andry#set_default_theme()

    exec "language " . saved_lang
    let &spell = saved_spell
endfunction()
