" core-style tag support
syn include @polymerCss syntax/css.vim
unlet b:current_syntax
syn region polymerCoreStyle start=+<core-style+ keepend end=+</core-style>+ contains=@htmlCss,@polymerCss,htmlTag,htmlEndTag,htmlCssStyleComment,@htmlPreproc
syn region htmlHead start="<head\>" end="</head>"me=e-7 end="<body\>"me=e-5 end="<h[1-6]\>"me=e-3 contains=htmlTag,htmlEndTag,htmlSpecialChar,htmlPreProc,htmlComment,htmlLink,htmlTitle,javaScript,cssStyle,polymerCoreStyle,@htmlPreproc
