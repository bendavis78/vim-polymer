if exists('g:loaded_syntastic_html_polylint_checker')
    finish
endif
let g:loaded_syntastic_html_polylint_checker = 1

let s:save_cpo = &cpo
set cpo&vim

function! SyntaxCheckers_html_polylint_IsAvailable() dict
    return executable(self.getExec())
endfunction

function! SyntaxCheckers_html_polylint_GetHighlightRegex(item)
    return ''
endfunction

function! SyntaxCheckers_html_polylint_GetLocList() dict
    let makeprg = self.makeprgBuild({
                \ 'args': '--no-recursion'})

    let errorformat = '%A%f:%l:%c,%Z    %m'

    let env = {}

    return SyntasticMake({
        \ 'makeprg': makeprg,
        \ 'errorformat': errorformat,
        \ 'env': env })

endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
            \ 'filetype': 'html',
            \ 'name': 'polylint',
            \ 'exec': 'polylint' })

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set sw=4 sts=4 et fdm=marker:
