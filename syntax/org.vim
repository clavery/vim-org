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
syntax keyword noteState NOTE
syntax keyword canceledStates CANCELED DEFERRED
syntax match project /\*\+.\+\*\+/
syntax match listStartTodo /^\s\+-/
syntax match questionStartTodo /^\s\+?/
syntax match listStartDone /^\s\++.\+$/
syntax match listNote /^\s\+\*.\+$/
syntax match importantStart /^\s\{-}!.\+$/
syntax match doneLine /DONE.\+$/
syntax match canceledLine /CANCELED.\+$/
syn match taskDatestamp		display '\[... \d\d/\d\d \d\d:\d\d\]'
syntax case ignore

syntax region metaDataTags start=/\sTAGS/ end=/$/
syntax region metaDataDue start=/\sDUE/ end=/$/
syntax region todoRegion start=/TODO/ end=/^$/ fold transparent
syntax region projectRegion start=/\*\+.\+\*\+/ end=/\(\*\+\)\@=/ fold transparent


hi def link todoStates  Function
hi def link listStartTodo Constant
hi def link questionStartTodo Special
hi def link doneLine Comment
hi def link taskDateStamp Comment
hi def link canceledLine Comment
hi def link doneStates Comment
hi def link listStartDone  Comment
hi def link metaDataTags Comment
hi def link metaDataDue Comment
hi def link noteState Constant
hi def link importantStart Keyword
hi def link project Constant
hi def link listNote Label
hi def link holdStates Identifier

