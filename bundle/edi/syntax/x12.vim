" Vim Syntax file
" Language: X12 EDI files
" Filenames: *.x12

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syntax match X12Keyword "^[A-Z0-9]\+"  " The first word on each line is the keyword
syntax match X12Header "^ST"  "The start and end of a section, just highlight this a little better
syntax match X12Header "^SE"  "The start and end of a section, just highlight this a little better
syntax match X12Header "^ISA"  "The start and end of a section, just highlight this a little better
syntax match X12Header "^IEA"  "The start and end of a section, just highlight this a little better
syntax match X12Header "^GS"  "The start and end of a section, just highlight this a little better
syntax match X12Header "^GE"  "The start and end of a section, just highlight this a little better
syntax match X12Delim "\~"  " Record Delimiter
syntax match X12Ops "\*"  " Item Separator
syntax match X12Sep "\:"  " Not sure?

hi def link X12Keyword Identifier
hi def link X12Header  Comment
hi def link X12Ops     Label
hi def link X12Delim   String
hi def link X12Sep     Special

let b:current_syntax = "x12"
