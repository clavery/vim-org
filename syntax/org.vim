" Save compatibility and force vim compatibility
let s:cpo_save = &cpo
set cpo&vim

syntax case match
syntax clear
syntax keyword todoStates TODO APPT PAY BUY
syntax keyword holdStates HOLD WAITING CLIENT
syntax keyword doneStates DONE
syntax keyword canceledStates CANCELED DEFERRED

syntax match tag /\v:\w+:/

syntax match projectOne /^\s\{2\}\*\+\s\+.\+$/ contains=holdStates,todoStates,doneStates,canceledStates,tag
syntax match projectTwo /^\s\{4\}\*\+\s\+.\+$/ contains=holdStates,todoStates,doneStates,canceledStates,tag
syntax match projectRoot /^\*\s\+.\+$/ contains=holdStates,todoStates,doneStates,canceledStates,tag
syntax match listStart /^\s\+-/
syntax match questionStartTodo /^\s\+?/
syntax match listStartDone /^\s\++.\+$/
syntax match importantStart /^\s\{-}!.\+$/
syntax match doneLine /^\s*\*\sDONE.\+$/
syntax match canceledLine /CANCELED.\+$/
syn match taskDatestamp		display '\[... \d\d/\d\d \d\d:\d\d\]'
syntax case ignore

syntax region drawerRegion start=+:.\+:+ end=+:END:+

hi def link todoStates Function
hi def link listStart Constant
hi def link questionStartTodo Special
hi def link doneLine Comment
hi def link taskDateStamp Comment
hi def link canceledLine Comment
hi def link doneStates Comment
hi def link drawerRegion Comment
hi def link listStartDone  Comment
hi def link noteState Constant
hi def link importantStart Keyword
hi def link projectRoot Constant
hi def link projectOne Function
hi def link projectTwo String
hi def link holdStates Identifier

hi Folded term=None ctermbg=None ctermfg=8 guibg=NONE
