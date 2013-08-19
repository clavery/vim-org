" Save compatibility and force vim compatibility
let s:cpo_save = &cpo
set cpo&vim

setlocal foldmethod=syntax
syntax case match
syntax clear

setlocal foldmethod=syntax
syntax keyword todoStates TODO APPT PAY BUY
syntax keyword holdStates HOLD WAITING CLIENT
syntax keyword doneStates DONE
syntax keyword canceledStates CANCELED DEFERRED
syntax match projectOne /^\s\{2\}\*\+\s\+.\+$/
syntax match projectTwo /^\s\{4\}\*\+\s\+.\+$/
syntax match projectRoot /^\*\s\+.\+$/
syntax match listStart /^\s\+-/
syntax match questionStartTodo /^\s\+?/
syntax match listStartDone /^\s\++.\+$/
syntax match importantStart /^\s\{-}!.\+$/
syntax match doneLine /DONE.\+$/
syntax match canceledLine /CANCELED.\+$/
syn match taskDatestamp		display '\[... \d\d/\d\d \d\d:\d\d\]'
syntax case ignore

syntax region projectRegion start=/\*\+.\+/ end=/\(\*\+\)\@=/ transparent


hi def link todoStates Function
hi def link listStart Constant
hi def link questionStartTodo Special
hi def link doneLine Comment
hi def link taskDateStamp Comment
hi def link canceledLine Comment
hi def link doneStates Comment
hi def link listStartDone  Comment
hi def link noteState Constant
hi def link importantStart Keyword
hi def link projectRoot Constant
hi def link projectOne Function
hi def link projectTwo Identifier
hi def link holdStates Identifier

