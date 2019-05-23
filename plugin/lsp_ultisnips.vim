if exists('g:lsp_ultisnips_loaded')
    finish
endif
let g:lsp_ultisnips_loaded = 1

let g:lsp_snippets_get_snippet = [function('lsp_ultisnips#get_snippet')]
let g:lsp_snippets_expand_snippet = [function('lsp_ultisnips#expand_snippet')]
