if exists("b:current_syntax")
  finish
endif

syn region syslogContext start="\[" end="\]" nextgroup=syslogMessage contained
syn region syslogPid     start="\[" end="\]" contained
syn match  syslogTime    "\d\{4}-\d\{2}-\d\{2} \d\{2}:\d\{2}:\d\{2}.\d\{3}" nextgroup=syslogPid skipwhite contained
syn match  syslogHost    "^[^ ]\+" nextgroup=syslogTime skipwhite contained

syn match syslogFatal " FATAL " contained nextgroup=syslogContext
syn match syslogFatal " CRITICAL " contained nextgroup=syslogContext
syn match syslogError " ERROR " contained nextgroup=syslogContext
syn match syslogWarn " WARN " contained nextgroup=syslogContext
syn match syslogWarn " WARNING " contained nextgroup=syslogContext
syn match syslogInfo " INFO " contained nextgroup=syslogContext
syn match syslogDebug " DEBUG " contained nextgroup=syslogContext

syn match  syslogText    "^.*$" contains=syslogHost,sysLogTime,syslogPid,syslogMessage,syslogFatal,syslogError,syslogWarn,syslogInfo,syslogDebug

hi def link syslogHost    Type
hi def link syslogTime    Comment
hi def link syslogPid     Type
hi def link syslogContext Type
hi def link syslogText    String

hi def syslogFatal ctermfg=Magenta guifg=Magenta
hi def syslogError ctermfg=Red     guifg=Red
hi def syslogWarn  ctermfg=Yellow  guifg=Yellow
hi def syslogInfo  ctermfg=Green   guifg=Green
hi def syslogDebug ctermfg=Gray    guifg=Gray

let b:current_syntax="syslog"
