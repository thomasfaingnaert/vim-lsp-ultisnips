function! lsp_ultisnips#get_vim_completion_item(item, ...) abort
    let a:item['label'] = trim(a:item['label'])

    let l:completion = call(function('lsp#omni#default_get_vim_completion_item'), [a:item] + a:000)

    " Set trigger and snippet
    if has_key(a:item, 'insertTextFormat') && a:item['insertTextFormat'] == 2
        if has_key(a:item, 'insertText')
            let l:trigger = a:item['label']
            let l:snippet = substitute(a:item['insertText'], '\%x00', '\\n', 'g')

            let l:user_data = {'vim-lsp-ultisnips': { 'trigger': l:trigger, 'snippet': l:snippet } }
            let l:completion['user_data'] = json_encode(l:user_data)
        elseif has_key(a:item, 'textEdit')
            let l:user_data = json_decode(l:completion['user_data'])

            let l:trigger = a:item['label']
            let l:snippet = l:user_data['vim-lsp/textEdit']['newText']

            let l:user_data['vim-lsp/textEdit']['newText'] = l:trigger

            let l:user_data['vim-lsp-ultisnips'] = { 'trigger': l:trigger, 'snippet': l:snippet }
            let l:completion['user_data'] = json_encode(l:user_data)
        endif
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

    let l:user_data = json_decode(a:item['user_data'])

    let s:trigger = l:user_data['vim-lsp-ultisnips']['trigger']
    let s:snippet = l:user_data['vim-lsp-ultisnips']['snippet']

    call timer_start(0, function('s:expand_snippet'))
endfunction

augroup lsp_ultisnips
    autocmd!
    autocmd CompleteDone * call s:handle_snippet(v:completed_item)
augroup END
