function! lsp_ultisnips#get_snippet(text) abort
    call lsp#log("Item:", a:text)
    return substitute(a:text, '\%x00', '\\n', 'g')
endfunction

function! lsp_ultisnips#expand_snippet(trigger, snippet)
    call lsp#log("Expanding snippet", a:trigger, a:snippet)
    call feedkeys("\<C-r>=UltiSnips#Anon(\"" . a:snippet . "\", \"" . a:trigger . "\", '', 'i')\<CR>")
endfunction
