" Make sure the correct filetype is applied to these files:
autocmd BufRead *.zcml set filetype=xml
autocmd BufRead *.ctp set filetype=php
autocmd BufRead *.htm set filetype=php
autocmd BufRead *.html set filetype=php
autocmd BufRead *.t set filetype=perl
autocmd BufRead *.thtml set filetype=php
autocmd BufRead * if match(expand("%:p:h"), 'config/cron') > 0 | set ft=crontab | endif
autocmd BufRead psql.edit.* set filetype=psql
autocmd BufRead *.txt set filetype=rst
autocmd BufRead *.mako set filetype=mako
autocmd BufRead *.py_tmpl set filetype=python
autocmd BufRead *.pp set filetype=conf
autocmd BufRead Vagrantfile set filetype=puppet
autocmd! BufRead,BufNewFile *.json set filetype=json
