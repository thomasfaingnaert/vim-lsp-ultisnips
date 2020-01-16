function! Sleep() abort
    sleep 100m
    return ''
endfunction

function! Quit() abort
    call feedkeys("\<Esc>")
    let l:content = getbufline('%', 1, '$')
    call writefile(l:content, 'test.log')
    qall!
endfunction

function! FillIn() abort
    if mode() == 's'
        call timer_start(100, {_ -> Quit()})
        call feedkeys("int\<Tab> v;")
    endif
endfunction

function! s:run()
    inoremap <C-l> <C-r>=Sleep()<CR>

    edit! test.cpp

    normal! 6G
    call timer_start(0, {_ -> feedkeys("o\<C-l>std::vec\<C-x>\<C-o>\<C-l>\<C-y>")})
    call timer_start(100, {_ -> FillIn()}, {'repeat': -1})
endfunction

call s:run()
