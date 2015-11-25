" core-style tag support
if exists("main_syntax")
  if main_syntax != "html"
    finish
  endif
endif
runtime! syntax/css.vim
unlet b:current_syntax

" Less strict highlighting on element attributes
syn match htmlArg contained "\<[-a-zA-Z0-9]\+[ $=>]"me=e-1

syn region polymerBoundVarRegion matchgroup=Delimiter start="{{" end="}}" keepend
syn sync match polymerBoundVarRegionSync grouphere polymerBoundVarRegion "^\s*{{\s*$" 
syn sync match polymerBoundVarRegionSync grouphere NONE "^\s*}}\s*$" 

syn region polymerOneWayBoundVarRegion matchgroup=Delimiter start="\[\[" end="\]\]" keepend
syn sync match polymerOneWayBoundVarRegionSync grouphere polymerOneWayBoundVarRegion "^\s*\[\[\s*$" 
syn sync match polymerOneWayBoundVarRegionSync grouphere NONE "^\s*\]\]\s*$" 

syn cluster htmlPreproc add=polymerBoundVarRegion
syn cluster htmlPreproc add=polymerOneWayBoundVarRegion
hi link polymerBoundVarRegion Special
hi link polymerOneWayBoundVarRegion Special

