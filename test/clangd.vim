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
        call timer_stop(s:timer)
        call timer_start(100, {_ -> feedkeys("1\<Tab>")})
        call timer_start(200, {_ -> feedkeys("2\<Tab>")})
        call timer_start(300, {_ -> feedkeys(";")})
        call timer_start(400, {_ -> Quit()})
    endif
endfunction

function! s:run()
    inoremap <C-l> <C-r>=Sleep()<CR>
    snoremap <C-l> <C-r>=Sleep()<CR>

    edit! test.cpp

    normal! 8G
    call timer_start(0, {_ -> feedkeys("o\<C-l>fo\<C-x>\<C-o>\<C-l>\<C-y>")})
    let s:timer = timer_start(100, {_ -> FillIn()}, {'repeat': -1})
endfunction

call s:run()
