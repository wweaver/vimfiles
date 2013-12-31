""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General                                                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible         " Get rid of Vi compatibility mode. SET FIRST!
set isk+=_,-             " Make these characters count as part of a word.
set viminfo+=!           " Make sure we can save viminfo.
set autoread             " Automatically read changes when files change in file system
set autowrite            " Automatically write changes when running :make.
set hidden               " Allow buffer nav without being forced to save
set encoding=utf-8
set showcmd              " display incomplete commands
set laststatus=2         " Always show the statusline
set wildignore=*.pyc,*.pyo,*/build,*.egg,*/env,*/*.egg-info  " Ignore these in most searches
set wildmode=longest,list,full  " Tab completion for filename autocomplete
set wildmenu             " allow wildmode autocompletion

if filereadable($HOME."/.vim/tags")
    set tags=~/.vim/tags
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Load pathogen so that we can load all of our dependencies
call pathogen#infect()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetypes                                                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype on                " Make Vim aware of the file type.
filetype plugin indent on  " Use plugins when available.

" File type declarations have been moved to filetype.vim

autocmd FileType make setlocal noet sw=8
autocmd FileType txt setlocal wrap
autocmd FileType txt setlocal spell spelllang=en_us
autocmd FileType txt setlocal binary | setlocal noeol
autocmd FileType mako setlocal binary | setlocal noeol
autocmd FileType mako setlocal spell spelllang=en_us
autocmd FileType mako setlocal textwidth=72
autocmd FileType confluencewiki setlocal spell spelllang=en_us

" Remove trailing whitespace
autocmd BufWritePre * %s/\s\+$//e

function! PerlPrefs()
    setlocal makeprg=perl\ -c\ %
    setlocal errorformat=%f:%l:%m
    iab echo print
    set path+=~/svn/trunk/code/awlib/AW,/etc/perl,/usr/local/lib/perl/5.8.8,/usr/local/share/perl/5.8.8,/usr/lib/perl5,/usr/share/perl5,/usr/lib/perl/5.8,/usr/share/perl/5.8
    nmap <leader>m :vimgrep /^\s*sub / %<CR>:cw<CR>zO
endfunction
au FileType perl call PerlPrefs()

function! PythonPrefs()
    setlocal makeprg=(echo\ '[%:p]';\ /Users/willw/bin/local/rpylint\ --include-pep8\ %:p)
    setlocal errorformat=%f:%l:%c:\ %m,%f:%l:\ %m
    setlocal keywordprg=pydoc
    setlocal isk-=:
    if IsPythonTestFile()
        setlocal textwidth=100
    else
        setlocal textwidth=79
    endif
    if has("gui_running")
        "if IsPythonTestFile()
        "    setlocal colorcolumn=101
        "else
        setlocal colorcolumn=80
        "endif
    endif

    let python_highlight_all = 1
    nmap <leader>m :vimgrep /^\s*def / %<CR>:cw<CR>zO
endfunction
au FileType python call PythonPrefs()

function! PhpPrefs()
    match Error /}\zs \/\/ \?close.*$/
    setlocal textwidth=120
    setlocal isk-=-
    setlocal makeprg=php\ -l\ %
    setlocal errorformat=%t:\ %m\ in\ %f\ on\ line\ %l
    setlocal keywordprg=~/bin/php_doc
endfunction
au FileType php call PhpPrefs()

function! JavascriptPrefs()
    setlocal textwidth=80
    setlocal errorformat=%t:\ %m\ in\ %f\ on\ line\ %l
endfunction
au FileType javascript call JavascriptPrefs()


function! IsPythonTestFile()
    return strpart(expand('%:t'), 0, 5) == 'test_'
endfunction

au BufEnter * if &filetype == "python" | if IsPythonTestFile()  | syntax match ErrorMsg '\%>100v.\+' | else | syntax match ErrorMsg '\%>79v.\+' | endif | endif
"au BufEnter * if &filetype == "php" | syntax match ErrorMsg '\%>120v.\+' | endif
au BufEnter * if &filetype == "javascript" | syntax match ErrorMsg '\%>80v.\+' | endif

function SetWrap()
    setlocal wrap linebreak nolist
    set virtualedit=
    setlocal display+=lastline
    noremap  <buffer> <silent> <Up>   gk
    noremap  <buffer> <silent> <Down> gj
    noremap  <buffer> <silent> <Home> g<Home>
    noremap  <buffer> <silent> <End>  g<End>
    inoremap <buffer> <silent> <Up>   <C-o>gk
    inoremap <buffer> <silent> <Down> <C-o>gj
    inoremap <buffer> <silent> <Home> <C-o>g<Home>
    inoremap <buffer> <silent> <End>  <C-o>g<End>
endfunction

autocmd FileType markdown call SetWrap()
autocmd FileType confluencewiki call SetWrap()
autocmd FileType php call SetWrap()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Theme/Colors                                                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256             " Enable 256-color mode.
syntax enable            " Enable syntax highlighting (previously syntax on).

syn keyword Todo contained TODO FIXME XXX NOTE
hi link awError Error
match awError /^[} \t]*\zs\(else\?\)\? \?if(/"


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim UI                                                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ruler                " Always show info along bottom.
set noerrorbells         " Disable error bells.
set ve=block

if version >= 700
   set showtabline=2     " Always show tab bar.

   " Use longest common text for completion.
   set completeopt=longest,menuone
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual Cues                                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set showmatch            " Show matching braces and brackets.
set mat=5                " How many tenths of a second to show a match.
set nohlsearch           " Don't continue to highlight searched phrases.
set incsearch            " But do highlight as you type your search.
set ignorecase           " Make searches case-insensitive.
set smartcase            " Override ignorecase when caps are used.
set so=5                 " Keep 5 lines for scope.
set siso=5               " Keep 5 lines for scope.
set nu                   " Show line numbers
" Get rid of bell and visualbell
set visualbell t_vb=
if has("multi_byte")
    scriptencoding utf-8  " Make sure the following is read as utf8.
    set list listchars=tab:»·,trail:·,nbsp:·
    scriptencoding
endif



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text Formatting/Layout                                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set fo=tcrqn                    " See help (complex).
set ai                          " Auto-indent.
set cinkeys-=0#                 " Prevent unindenting of '#'.
set tabstop=4                   " Tab spacing (settings below correspond to unify.
set softtabstop=4               " Unify.
set shiftwidth=4                " Indent/outdent by 4 columns.
set shiftround                  " Always indent/outdent to the nearest tabstop.
set expandtab                   " Use spaces instead of tabs.
set smarttab                    " Use tabs at the start of a line, spaces elsewhere.
set nowrap                      " Do or don't wrap text(wrap/nowrap)
set backspace=indent,eol,start  " backspace through everything in insert mode


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding                                                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable folding and make it indent-sensitive.
if version >= 600
    set foldenable
    set foldmethod=indent
    set foldnestmax=2
    set foldlevelstart=20
    "set foldlevel=100
    "set fmr={,}
    "set foldminlines=4
endif
"set foldopen-=search     " Don't open folds when you search into them.
"set foldopen-=undo       " Don't open folds when you undo stuff.


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings                                                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Make Y more logical:
nmap Y y$

" Remap ^d to quit vim:
nmap <C-d> :quit<CR>

nmap <leader>w /[A-Z]<CR>

" Extend <C-l>:
nnoremap <C-l> :set nohls<CR><C-l>

" Visual searching:
vnoremap * y/\V<C-R>=substitute(escape(@@,"/\\"),"\n","\\\\n","ge")<CR><CR>
vnoremap # y?\V<C-R>=substitute(escape(@@,"?\\"),"\n","\\\\n","ge")<CR><CR>

" Remap F1 to escape, since this is a common mistype:
map <F1> <Esc>
imap <F1> <Esc>

" Change the cwd of vim to the main directory of our app.
noremap <F2> :cd <C-R>=expand("%:p:h")<CR><CR>

" Commit all open buffers to SVN.
map <F3> :!open <C-r>=expand("%:h")<CR><CR>

" Run make on current file.
map <silent> <F5> :VCSBlame<CR>

" SVN Diff the given file.
map <silent> <F6> :VCSDiff<CR>
map <C-F8> :%s/\s\+$//<CR>
map <F13> :%s/\s\+$//e<CR>
map <C-F12> :BufExplorer<CR>
map <F14> :BufExplorer<CR>
map <F16> :MRU<CR>

" Command-t settings and mappings
" map <C-t> <Esc>:CommandT<CR>
" map ,t <Esc>:CommandT<CR>
" let g:CommandTMaxHeight=30


" Ctrlp settings and mappings
map <C-t> <Esc>:CtrlP .<CR>
map ,t <Esc>:CtrlP .<CR>


vmap <s-down> <down>
map <s-down> <down>
vmap <s-up> <up>
map <s-up> <up>

nmap <Tab> <c-w><c-w>
nmap <S-Tab> <c-w><s-w>


" Turn on/off search highlighting.
map <silent> <leader>h :se invhlsearch<CR>

" Turn on/off highlighting of misspelled words.
if version >= 700
    autocmd FileType svn setlocal spell spelllang=en_us
    "map <F6> <Esc>:setlocal nospell<CR>
endif


" Complete some brackets to create matching end-bracket.
"inoremap <leader><tab>  <c-r>=MakeBlock()<cr>

" Reformat/reindent pasted text.
nnoremap <Esc>P P'[v']=
nnoremap <Esc>p p'[v']=

" Toggle fold under cursor.
nnoremap  <silent>  <space> :exe 'silent! normal! za'.(foldlevel('.')?'':'l')<cr>

" Columnate arrays/lists.
vmap <silent> <leader>= :Align => =<CR>

" Switch between double/single quotes:
nmap <leader>' di"hr'plr'
nmap <leader>" di'hr"plr"

" Faster access to common directories:
cmap <leader>a code/sites/aweber_app/
cmap <leader>w code/sites/aweber_app/webroot/

" List methods within file:
autocmd FileType php nmap <leader>m :vimgrep /^\s*\(private \\|public \)\?function / %<CR>:cw<CR>zO

" Add phpDoc-style comment to function:
nmap <leader>* ?function<CR>f(yi(O/**<CR><CR><CR><Esc>p'[a <Esc>:s/\$/@/ge<CR>:s/,\s*/\r * /ge<CR>o/<Esc>v?\/\*\*<CR>=jA

" Fill in a PHP function argument list:
nmap <silent> <leader>k :read !lynx -dump /usr/share/doc/php-doc/html/function.<C-R>=tr(expand("<cword>"), "_", "-")<CR>.html \| grep -A2 Description \| egrep -o "\(.*\)"<CR>kgJ

" Convert between underscore and camelcase:
nmap <leader>- ciw<C-R>=SwitchStyle("<C-R>"")<CR><ESC>

" SVN blame a block of text:
vmap <leader>b :<C-U>!svn blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

" Fuzzy Finder prompt:
map ,f :FufFile<CR>
map ,b :FufBuffer<CR>
map ,l :FufLine<CR>

" Buffer search
map ,s :Bs

vmap <C-m> :BikeExtract<CR>


" Remap Command-k to next buffer
nnoremap <special> <D-k> <Esc>:bn<CR>
vmap <special> <D-k> <Esc><D-k>gv
imap <special> <D-k> <C-O><D-k>
cmap <special> <D-k> <C-C><D-k>
omap <special> <D-k> <Esc><D-k>

" Remap Command-j to prev buffer
nnoremap <special> <D-j> <Esc>:bp<CR>
vmap <special> <D-j> <Esc><D-j>gv
imap <special> <D-j> <C-O><D-j>
cmap <special> <D-j> <C-C><D-j>
omap <special> <D-j> <Esc><D-j>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Abbreviations                                                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Other
iab dateR <C-r>=strftime("%a, %d %b %Y %H:%M:%S %z")<CR>
iab pgdate <C-r>=strftime("%Y-%m-%d 00:00:00")<CR>
iab pgtime <C-r>=strftime("%Y-%m-%d %H:%M:%S")<CR>
iab xymd <C-r>=strftime("%Y-%m-%d")<CR>
iab xdMy <C-r>=strftime("%d %M %Y")<CR>

" Faster project nav
cab AWEBER <C-r>=substitute(expand("%:p"), 'delmon', 'aweber', '')<CR>
cab TRUNK <C-r>=substitute(expand("%:p"), 'release', 'trunk', '')<CR>
cab REL <C-r>=substitute(expand("%:p"), 'trunk', 'release', '')<CR>
cab CONT <C-r>=substitute(expand("%:p"), 'models\|views', 'controllers', '')<CR>
cab MODEL <C-r>=substitute(expand("%:p"), 'controllers\|views', 'models', '')<CR>
cab VIEW <C-r>=substitute(expand("%:p"), 'controllers\|models', 'views', '')<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Functions                                                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CdToProjectBase()
   let _dir = strpart(expand("%:p:h"), 0, matchend(expand("%:p:h"), "_app"))
   exec "cd " . _dir
   unlet _dir
endfunction

function! Underscore2Camelcase(text)
   return substitute(a:text, "_\\([a-z]\\)", "\\U\\1", "g")
endfunction

function! Camelcase2Underscore(text)
   return substitute(a:text, "\\C\\([A-Z]\\)", "_\\L\\1", "g")
endfunction

function! SwitchStyle(text)
   if match(a:text, "_") > 0
      return Underscore2Camelcase(a:text)
   else
      return Camelcase2Underscore(a:text)
   fi
endfunction

function! CompleteBlock()
   return ") {\<CR>}\<Esc>kf)i"
endfunction

function! MakeBlock()
   return "(" . CompleteBlock()
endfunction

function! DimLogging()
    exec "hi DimmedLogging ctermfg=darkgray guibg=#333333"
    exec "match DimmedLogging /^\s*$self->log.*$/"
endfunction

function! SetWidth(width)
    execute "set tabstop=" . a:width
    execute "set softtabstop=" . a:width
    execute "set shiftwidth=" . a:width
    echo "Indentation width set to " . a:width
endfunction
command! -nargs=1 SetWidth call SetWidth(<q-args>)


function! ResetTabs()
    if has("multi_byte")
        execute "set list listchars=tab:»·,trail:·,nbsp:·"
    endif

    execute "set expandtab"
endfunction
command! -nargs=0 ResetTabs call ResetTabs()

autocmd FileType php call ResetTabs()

function! OpenTests(pbase, tbase, tglob)
    " TODO: use finddir with a contat'ed let/expand to recursively search for
    " the tests/ directory
    let testdir = substitute(expand("%:p:r"), a:pbase, a:tbase, "")
    if isdirectory(testdir)
        let testfiles = split(glob(testdir . "/" . a:tglob), "\0")
        if len(testfiles) == 0
            echo "No tests found in test directory"
        elseif len(testfiles) == 1
            execute "e " . testfiles[0]
        else
            execute "e " . testdir
        endif
    elseif filereadable(testdir . substitute(a:tglob, "*", "", ""))
        execute "e " . testdir . substitute(a:tglob, "*", "", "")
    else
        echo "Could not find test file(s) or directory"
    endif
endfunction
au FileType perl command! -nargs=0 Tests call OpenTests("awlib", "awlib/tests", "*.t")
au FileType python command! -nargs=0 Tests call OpenTests("Python", "Python/tests", "_test.py")

function! OpenPackageTests()
    let testdir = finddir("tests", expand("%:h").";")
    if strlen(testdir) > 0
        execute "e " . testdir
    else
        echo "Test directory not found"
    endif
endfunction

function! Pkg(name, path)
    let target = substitute(glob(a:path . '/*' . a:name . '*'), "\n.*", "", "")
    if isdirectory(target)
        let trunk = target . '/trunk'
        if isdirectory(trunk)
            echo 'Changing directory to ' . trunk
            execute "cd " . trunk
        else
            echo 'Changing directory to ' . target
            execute "cd " . target
        endif
    else
        echo "Project not found"
    endif
endfunction
command! -nargs=1 Pkg call Pkg(<q-args>, '~/svn/packages')
command! -nargs=1 Proj call Pkg(<q-args>, '~/svn/projects/python')


function! Project(type)
    let path = expand("%:~:p")
    if match(path, '\~/svn/packages/') == 0
        let search = "^\\(\\~/svn/packages\\)/\\([^/]*\\)/\\(.*\\)$"
    elseif match(path, '\~/svn/projects/python/') == 0
        let search = "^\\(\\~/svn/projects/python\\)/\\([^/]*\\)/\\(.*\\)$"
    elseif match(path, '\~/svn/trunk/code/sites/') >= 0
        let search = "^\\(.*code/sites\\)/\\([^/]*\\)/\\(.*\\)$"
    elseif match(path, '\~/svn/trunk/code/aw\(lib\|bin\)/') >= 0
        let search = "^\\(.*code\\)/\\([^/]*\\)/\\(.*\\)$"
    elseif match(path, '\~/svn/') >= 0
        let search = "^\\(\\~/svn\\)/\\([^/]*\\)/\\(.*\\)$"
    else
        let search = "\\(\\)\\(\\)\\(.*\\)"
    endif
    if a:type == 'name'
        return substitute(path, search, "\\2", "")
    elseif a:type == 'front'
        return substitute(path, search, "\\1", "")
    elseif a:type == 'end'
        return substitute(path, search, "\\3", "")
    endif
endfunction


function! Replace(srch, repl)
    execute '%s/<' . a:srch . '>/' . a:repl . '/g'
endfunction
command! -nargs=1 Cls call Replace('class', <q-args>)
command! -nargs=1 Mod call Replace('module', <q-args>)
command! -nargs=1 Fun call Replace('function', <q-args>)


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Macros                                                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Restore last edited position (help last-position-jump).
au BufReadPost * if line("'\"") > 0 &&
   \  line("'\"") <= line("$") | exe "normal g'\"" | endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Completion                                                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set complete=.
if filereadable($HOME."/.vim/complete")
    set complete+=k$HOME/.vim/complete
endif
if version >= 700
   autocmd FileType python set omnifunc=pythoncomplete#Complete
   autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
   autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
   autocmd FileType css set omnifunc=csscomplete#CompleteCSS
   autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
   autocmd FileType php set omnifunc=phpcomplete#CompletePHP
   autocmd FileType c set omnifunc=ccomplete#Complete
endif

let g:SuperTabDefaultCompletionType = "context"


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ack                                                                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let ackprg='/opt/local/libexec/perl5.12/sitebin/ack -H --nocolor --nogroup --column --ignore-dir=env'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Taglist                                                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctags_statusline=1          " Display function name in status bar
let generate_tags=1               " Automatically start script
let Tlist_Use_Horiz_Window=0      " Display tag results in vertical window
nnoremap TT :TlistToggle<CR>
let Tlist_Use_Right_Window=1
let Tlist_Compact_Format=1
let Tlist_Exit_OnlyWindow=1
let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_File_Fold_Auto_Close=1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree                                                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-F9> :NERDTreeToggle<CR>
map <F15> :NERDTreeToggle<CR>
noremap <leader>nt <ESC>:NERDTreeToggle<CR>

let NERDTreeIgnore=[
    \ '\~$', '\.pyc$', '\.egg-info$', '_compressed\.js$',
    \ '^build-python2\.[56]$', '^tags$', '^branches$', '^Icon.$',
    \ '^dist$', '^build$', '^reports$', '^__pycache__$'
    \ ]
let NERDTreeWinPos='right'
let NERDTreeSortOrder=['__*\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let NERDTreeWinSize=45


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TagBar                                                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <F19> :TagbarToggle<CR>
map <leader>tb :TagbarToggle<CR>

let g:tagbar_left = 1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BufExplorer                                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:bufExplorerSortBy='fullpath'
let g:bufExplorerShowTabBuffer=1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Project                                                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let $PROJECT_HOME='~/git'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Grep                                                                       "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! QFixToggle(forced)
    if exists("g:qfix_win") && a:forced == 0
        cclose
    else
        execute "copen"
    endif
endfunction

" Used to track the quickfix window.
augroup QFixToggle
    autocmd!
    autocmd BufWinEnter quickfix let g:qfix_win = bufnr("$")
    autocmd BufWinLeave * if exists("g:qfix_win") && expand("<abuf>") == g:qfix_win | unlet! g:qfix_win | endif
augroup END
" '\g' : grep all open buffers
noremap <Leader>g <Esc>:GrepBuffer <CR>

" '\gg' : grep all open buffers for word under cursor
noremap <Leader>gg <Esc>:GrepBuffer <C-R><C-W><CR>

" '\G' : recursively grep through filesystem
noremap <Leader>G <Esc>:Rgrep<CR>

" '\qq' : toggle QuickFix window (errors and vimgrep results here)
noremap <silent><leader>qq <Esc>:call QFixToggle(0)<CR>

" '[q' previous quickfix entry
map [q :cprev<CR>

" ']q' next quickfix entry
map ]q :cnext<CR>

" '\q*' : search for occurrences of word under cursor, and write to QuickFix
noremap <silent><leader>q*  <Esc>:execute 'vimgrep '.expand('<cword>').' '.expand('%') <CR> :copen <CR> :cc

" Vimgrep mappings
map <F4> :execute "vimgrep /" . input('Enter search term: ') . "/j " .  input('Enter directory: ', getcwd()) . "/**/*.py" <Bar> cw<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Gist                                                                       "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:github_api_url = 'https://github-enterprise.colo.lair/api/v3'
let g:github_user = 'willw'
let g:gist_open_browser_after_post = 1
let g:gist_clip_command = 'pbcopy'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Gist                                                                       "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:jira_browse_url = 'https://jira.colo.lair/browse/'

if &diff
    set t_Co=256
    set background=dark
    colorscheme peaksea
else
    colorscheme desert
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GVim                                                                       "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("gui_running")
    set lines=52 columns=120
    set guioptions-=T
    set guioptions-=m
    set guicursor=a:blinkon0  " Disable gui cursor blinking.
    set wildmenu

    " Change color scheme.
    if filereadable($HOME."/.vim/colors/desert256.vim") || filereadable($VIMRUNTIME."/colors/desert256.vim")
        colorscheme desert256
    endif

    set cursorline
    highlight CursorLine guibg=#111111
    highlight CursorColumn guibg=#111111
    highlight ColorColumn guibg=#111111
endif

let g:snippets_dir = "~/.vim/snippets"
source ~/.vim/snippets/python/AWeber.vim
