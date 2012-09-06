fun! ModelFromTest(...)
    let filename = expand('%:t:r')
    let under_name = substitute(filename, '^test_\(.\+\)', '\u\1', 'g')
    return substitute(under_name, '_\(.\)', '\u\1', 'g')
endf

fun! InstanceFromTest(...)
    let filename = expand('%:t:r')
    return substitute(filename, '^test_', '', '')
endf

au BufEnter * if &filetype == 'python' | let $MODEL = ModelFromTest() | endif
au BufEnter * if &filetype == 'python' | let $INSTANCE = InstanceFromTest() | endif
