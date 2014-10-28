if exists("g:loaded_syntastic_html_polylint_checker")
    finish
endif
let g:loaded_syntastic_html_polylint_checker = 1

let s:save_cpo = &cpo
set cpo&vim

let g:syntastic_debug = 2

function! SyntaxCheckers_html_polylint_GetHighlightRegex(item)
    let import_match = matchlist(a:item['text'], \
        "\bcouldn't find imported asset \"(.*)\"")
    if len(import_match) > 0:
        return import_match[1];
    endif

    let elem_match = matchlist(a:item['text'], \
        '\vcustom element with name "(.*)" not found.')
    if len(elem_match) > 0:
        return elem_match[1];
    endif

    return ''
endfunction

function! SyntaxCheckers_html_polylint_GetLocList() dict
    let makeprg = self.makeprgBuild({})

    let errorformat =
        \ '%Wwarning line %l, column %v of %f: %m,' .
        \ '%Eerror line %l, column %v of %f: %m,' .
        \ '%-G%.%#'

    return SyntasticMake({
            \ 'makeprg': makeprg,
            \ 'errorformat': errorformat,
            \ 'defaults': {'bufnr': bufnr("")},
            \ 'returns': [0] })
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
        \ 'filetype': 'html',
        \ 'name': 'polylint' })

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set et sts=4 sw=4:
