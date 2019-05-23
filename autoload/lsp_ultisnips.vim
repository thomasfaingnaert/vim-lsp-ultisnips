function! lsp_ultisnips#get_snippet(text) abort
    return substitute(a:text, '\%x00', '\\n', 'g')
endfunction

function! lsp_ultisnips#expand_snippet(trigger, snippet)
    call feedkeys("\<C-r>=UltiSnips#Anon(\"" . a:snippet . "\", \"" . a:trigger . "\", '', 'i')\<CR>")
endfunction
