function! s:escape_string(str) abort
    let l:ret = substitute(a:str, '\%x00', '\\n', 'g')
    let l:ret = substitute(l:ret, '"', '\\"', 'g')
    return l:ret
endfunction

function! lsp_ultisnips#get_snippet(text) abort
    return s:escape_string(a:text)
endfunction

function! lsp_ultisnips#expand_snippet(trigger, snippet)
    call feedkeys("\<C-r>=UltiSnips#Anon(\"" . a:snippet . "\", \"" . s:escape_string(a:trigger) . "\", '', 'i')\<CR>")
endfunction
