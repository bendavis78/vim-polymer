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
    vim.command("let safejson = '{}'")
endpython
return eval(safejson)
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
            call add(loclist, { 
                \ "valid": 1,
                \ "type": error['level'][0],
                \ "lnum": error['line'],
                \ "vcol": error['col'],
                \ "text": error['message'],
                \ "bufnr": bufnr(error['file'])})
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
