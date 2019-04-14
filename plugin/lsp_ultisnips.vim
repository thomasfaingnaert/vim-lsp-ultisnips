if exists('g:lsp_ultisnips_loaded')
    finish
endif
let g:lsp_ultisnips_loaded = 1

let g:lsp_get_vim_completion_item = [function('lsp_ultisnips#get_vim_completion_item')]
let g:lsp_get_supported_capabilities = [function('lsp_ultisnips#get_supported_capabilities')]
