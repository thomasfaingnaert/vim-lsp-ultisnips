function! lsp_ultisnips#get_vim_completion_item(item, ...) abort
    let a:item['label'] = trim(a:item['label'])

    let l:completion = call(function('lsp#omni#default_get_vim_completion_item'), [a:item] + a:000)

    if has_key(a:item, 'insertTextFormat') && a:item['insertTextFormat'] == 2
        let l:trigger = a:item['label']
        let l:snippet = substitute(a:item['insertText'], '\%x00', '\\n', 'g')

        let l:completion['user_data'] = string([l:trigger, l:snippet])
    endif

    return l:completion
endfunction

function! lsp_ultisnips#get_supported_capabilities(server_info) abort
    let l:capabilities = lsp#default_get_supported_capabilities(a:server_info)

    if has_key(a:server_info, 'config') && has_key(a:server_info['config'], 'snippets') &&
                \ a:server_info['config']['snippets'] == 0
        return l:capabilities
    endif

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
