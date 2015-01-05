
" Core Elements
syn match polymerCoreElement "core-\(ajax\|animated-pages\|animation\|collapse\|doc-viewer\|docs\|drag-drop\|drawer-panel\|dropdown\|dropdown-menu\|field\|header-panel\|icon-button\|icons\|image\|input\|item\|layout-grid\|layout-trbl\|list\|localstorage\|media-query\|menu\|menu-button\|meta\|overlay\|pages\|range\|scaffold\|scroll-header-panel\|selection\|selector\|shared-lib\|signals\|splitter\|style\|tests\|toolbar\|tooltip\|transition\)"

" Paper Elements
syn match polymerPaperElement "paper-\(button\|checkbox\|dialog\|dropdown-menu\|fab\|icon-button\|input-decorator\|input\|item\|menu-button\|progress\|radio-button\|radio-group\|ripple\|shadow\|slider\|tabs\|toast\|toggle-button\)"

" ShadowDOM selectors
syn match shadowDomSelector "\s\+\(/deep/\|:host\|::shadow\|::content\)\s\+"

" Custom Elements
syn match customElement "([a-z]-)+[a-z]+"

hi link polymerCoreElement cssTagName
hi link polymerPaperElement cssTagName
hi link customElement cssSelectorOp
hi link shadowDomSelector cssSelectorOp
