if exists('g:lsp_ultisnips_loaded')
    finish
endif
let g:lsp_ultisnips_loaded = 1

let g:lsp_snippet_expand = [function('lsp_ultisnips#expand_snippet')]
