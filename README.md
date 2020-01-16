# vim-lsp-ultisnips
![](https://github.com/thomasfaingnaert/vim-lsp-ultisnips/workflows/CI/badge.svg)
This plugin integrates [UltiSnips](https://github.com/SirVer/ultisnips) in [vim-lsp](https://github.com/prabirshrestha/vim-lsp) to provide Language Server Protocol snippets.
You can use both Vim's built-in omnifunc or [asyncomplete.vim](https://github.com/prabirshrestha/asyncomplete.vim) for completion.

## Demo
![GIF demo](https://raw.githubusercontent.com/thomasfaingnaert/images/master/demo-ultisnips.gif)

## Quick Start
This plugin requires [UltiSnips](https://github.com/SirVer/ultisnips), [vim-lsp](https://github.com/prabirshrestha/vim-lsp) and their dependencies.
If these are already installed and you are using [vim-plug](https://github.com/junegunn/vim-plug), you can simply add this to your vimrc:
```vim
Plug 'thomasfaingnaert/vim-lsp-snippets'
Plug 'thomasfaingnaert/vim-lsp-ultisnips'
```

Otherwise, you can install these using [vim-plug](https://github.com/junegunn/vim-plug) as well:
```vim
Plug 'SirVer/ultisnips'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'thomasfaingnaert/vim-lsp-snippets'
Plug 'thomasfaingnaert/vim-lsp-ultisnips'
```

## Disable for specific language servers
By default, snippet integration is enabled for all language servers. You can disable snippets for one or more servers manually as follows:
```vim
autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'clangd',
            \ 'cmd': {server_info->['clangd']},
            \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
            \ 'config': { 'snippets': 0 }
            \ })
```

## Example Configuration (using omnifunc)
```vim
call plug#begin()

Plug 'SirVer/ultisnips'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'thomasfaingnaert/vim-lsp-snippets'
Plug 'thomasfaingnaert/vim-lsp-ultisnips'

call plug#end()

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

if executable('clangd')
    augroup vim_lsp_cpp
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'clangd',
                    \ 'cmd': {server_info->['clangd']},
                    \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
                    \ })
	autocmd FileType c,cpp,objc,objcpp,cc setlocal omnifunc=lsp#complete
    augroup end
endif

set completeopt+=menuone
```
