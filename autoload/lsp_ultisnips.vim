function! s:escape_string(str) abort
    let l:ret = substitute(a:str, '\\', '\\\\', 'g')
    let l:ret = substitute(l:ret, '\%x00', '\\n', 'g')
    let l:ret = substitute(l:ret, '"', '\\"', 'g')
    return l:ret
endfunction

function! lsp_ultisnips#expand_snippet(params)
    call feedkeys("\<C-r>=UltiSnips#Anon(\"" . s:escape_string(a:params.snippet) . "\", \"\", '', 'i')\<CR>")
endfunction
