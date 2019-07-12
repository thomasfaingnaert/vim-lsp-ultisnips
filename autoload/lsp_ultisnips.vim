function! lsp_ultisnips#get_snippet(text) abort
    let l:snippet = substitute(a:text, '\%x00', '\\n', 'g')
    let l:snippet = substitute(l:snippet, '"', '\\"', 'g')
    return l:snippet
endfunction

function! lsp_ultisnips#expand_snippet(trigger, snippet)
    call feedkeys("\<C-r>=UltiSnips#Anon(\"" . a:snippet . "\", \"" . a:trigger . "\", '', 'i')\<CR>")
endfunction
