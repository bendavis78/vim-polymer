if exists("g:loaded_syntastic_html_polylint_checker")
    finish
endif
let g:loaded_syntastic_html_polylint_checker = 1

let s:save_cpo = &cpo
set cpo&vim

function! SyntaxCheckers_html_polylint_GetHighlightRegex(item)
    if match(a:item['text'], 'Import resource not found') > -1
        let href = split(a:item['text'], ': ')[1]
        return href
    endif
    if match(a:item['text'], 'Element not defined') > -1
        let name = split(a:item['text'], ': ')[1]
        return split(name, '"')[0]
    endif
    return ''
endfunction

function! SyntaxCheckers_html_polylint_GetLocList() dict
    let makeprg = self.makeprgBuild({})

    let errorformat =
        \ '%Wline %l column %v - Warning: %m,' .
        \ '%Eline %l column %v - Error: %m,' .
        \ '%-G%.%#'

    return SyntasticMake({
            \ 'makeprg': makeprg,
            \ 'errorformat': errorformat,
            \ 'defaults': {'bufnr': bufnr("")} })
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
        \ 'filetype': 'html',
        \ 'name': 'polylint' })

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set et sts=4 sw=4:
