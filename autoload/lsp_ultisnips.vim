function! lsp_ultisnips#get_vim_completion_item(item, ...) abort
    let l:completion = call(function('lsp#omni#default_get_vim_completion_item'), [a:item] + a:000)

    if has_key(a:item, 'insertTextFormat') && a:item['insertTextFormat'] == 2
        let l:snippet = substitute(a:item['insertText'], '\%x00', '\\n', 'g')
        let l:word = trim(a:item['label'])
        let l:trigger = l:word
        let l:completion['user_data'] = string([l:trigger, l:snippet])
    endif

    return l:completion
endfunction

function! lsp_ultisnips#get_supported_capabilities() abort
    let l:capabilities = lsp#default_get_supported_capabilities()
    let l:capabilities['textDocument'] =
                \   {
                \       'completion': {
                \           'completionItem': {
                \               'snippetSupport': v:true
                \           }
                \       }
                \   }

    return l:capabilities
endfunction

function! s:expand_snippet(timer) abort
    call feedkeys("\<C-r>=UltiSnips#Anon(\"" . s:snippet . "\", \"" . s:trigger . "\", '', 'i')\<CR>")
endfunction

function! s:handle_snippet(item) abort
    if !has_key(a:item, 'user_data')
        return
    endif

    execute 'let l:user_data = ' . a:item['user_data']

    let s:trigger = l:user_data[0]
    let s:snippet = l:user_data[1]

    call timer_start(0, function('s:expand_snippet'))
endfunction

augroup lsp_ultisnips
    autocmd!
    autocmd CompleteDone * call s:handle_snippet(v:completed_item)
augroup END
