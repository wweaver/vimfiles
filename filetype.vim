" Make sure the correct filetype is applied to these files:
autocmd BufRead,BufNewFile * if match(expand("%:p:h"), 'config/cron') > 0 | set ft=crontab | endif
autocmd BufRead,BufNewFile README set filetype=text
autocmd BufRead,BufNewFile *.confluence set filetype=confluencewiki
autocmd BufRead,BufNewFile *.json set filetype=json
autocmd BufRead,BufNewFile *.log set filetype=syslog
autocmd BufRead,BufNewFile *.mako set filetype=mako
autocmd BufRead,BufNewFile *.pg set filetype=sql
autocmd BufRead,BufNewFile *.pp set filetype=puppet
autocmd BufRead,BufNewFile *.py_tmpl set filetype=python
autocmd BufRead,BufNewFile *.t set filetype=perl
"autocmd BufRead,BufNewFile *.txt set filetype=rst
autocmd BufRead,BufNewFile *.zcml set filetype=xml
autocmd BufRead,BufNewFile Makefile.inc set filetype=make
autocmd BufRead,BufNewFile Vagrantfile set filetype=ruby
"autocmd BufRead,BufNewFile psql.edit.* set filetype=psql

autocmd BufRead,BufNewFile *.x12 set filetype=x12
autocmd BufRead,BufNewFile *.edi set filetype=x12

" Cake files
"autocmd BufRead,BufNewFile *.ctp set filetype=php
"autocmd BufRead,BufNewFile *.htm set filetype=php
"autocmd BufRead,BufNewFile *.html set filetype=php
"autocmd BufRead,BufNewFile *.thtml set filetype=php
