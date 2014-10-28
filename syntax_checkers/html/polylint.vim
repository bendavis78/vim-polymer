if exists("g:loaded_syntastic_html_polylint_checker")
    finish
endif
let g:loaded_syntastic_html_polylint_checker = 1

let s:save_cpo = &cpo
set cpo&vim

let g:syntastic_debug = 0

function! SyntaxCheckers_html_polylint_GetHighlightRegex(item)
    return ''
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

function! <sid>ParseJSON(text)
python << endpython
import json, vim
unsafe_json = vim.eval('a:text')
try:
    safe_json = json.dumps(json.loads(unsafe_json))
    vim.command("let safejson = '%s'" % safe_json.replace("'", "''"))
except ValueError:
    vim.command("let safejson = '[{}]'")
endpython
return eval(safejson)[0]
endfunction

function! SyntaxCheckers_html_polylint_GetLocList() dict
    let makeprg = self.makeprgBuild({ 'args_before': '--json' })

    " Skip SyntasticMake since we have json output
    let lines = split(system(makeprg), "\n", 1)
    let loclist = []
    let c = 0
    for line in lines
        let error = s:ParseJSON(line)
        if len(error)
            let chr_start = error['params']['charStart']
            let len = error['params']['charEnd'] - chr_start
            let lineno = error['params']['line']
            let colno = chr_start - line2byte(lineno) + 2
            let msgmatch = matchlist(
                \ error['params']['message'],
                \ '\v^(.{-})( See http:\/\/goo.gl\/5HPeuP#polymer_(\d+) for details\.)')
            let msg = msgmatch[1]
            let errno = msgmatch[3]
            let pattern = '^\(.\{-}\zs.\)\{'.colno.'}\(.\{-}.\)\{'.(len-1).'}'
            call add(loclist, { 
                \ "valid": 1,
                \ "type": error['method'] == 'error' ? 'E' : 'E',
                \ "lnum": lineno,
                \ "vcol": error['params']['charStart'],
                \ "text": msg,
                \ "bufnr": bufnr(error['params']['file']),
                \ "pattern": pattern,
                \ "nr": errno })
        endif
    endfor

    return loclist
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
        \ 'filetype': 'html',
        \ 'name': 'polylint' })

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set et sts=4 sw=4:
