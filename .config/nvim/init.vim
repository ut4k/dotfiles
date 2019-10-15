"basic{{{
autocmd ColorScheme * highlight User1 guifg=#ffcb6b guibg=0 gui=bold
autocmd ColorScheme * highlight User2 guifg=#c792ea guibg=0

scriptencoding utf-8
set encoding=utf-8

set termguicolors
set background=dark
set t_Co=256
set ttyfast
set updatetime=300
set shortmess+=c
set signcolumn=yes
" 保存されていないファイルがあるときでも別のファイルを開くことが出来る
set hidden
"global substitute by default ( /g )
set gdefault

set ignorecase
set smartcase
set list
set listchars=tab:»\ ,precedes:«,extends:»,eol:↲
set ambiwidth=double
"行間をでシームレスに移動する
set whichwrap+=h,l,<,>,[,],b,s

"カーソルを常に画面の中央に表示させる
" set scrolloff=999

set mouse=a
set ttimeoutlen=10
set backspace=indent,eol,start
set clipboard=unnamed

set autoread
set cursorline
set foldlevel=99
set hlsearch
set laststatus=2
set lazyredraw
set nobackup
set noruler
set noswapfile
set noundofile
set nowrap
set number
set regexpengine=1
set shiftwidth=2
set showcmd
set showmatch
set showmode
set smartcase
set splitright
set tabstop=2
set title
set titlestring=%{expand('%:p')}
set tags=tags

"todo
" syntax sync minlines=20000
set redrawtime=4000

"ワイルドカードで検索除外
set wildignore+=*\\.git\\*,*\\.hg\\*,*\\.svn\\*
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.jpg,*.png,*.gif,*.jpeg,*.swf
set wildignore+=*/.git/*,*/tmp/*,*.swp

"html output
let g:html_number_lines = 0
let g:html_ignore_folding = 1
let g:html_font = "Consolas"

"to enable termiguicolors in tmux
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

"diff setting
if &diff                             " only for diff mode/vimdiff
  set diffopt=filler,context:1000000 " filler is default and inserts empty lines for sync
endif
"}}}

"variable {{{
let $PRJCONF = "$HOME/.vim/config/prj.vim"
let $MYVIMRC2 = "$HOME/.vim/config/local.vim"
let $TMUXCONF = "$HOME/.tmux.conf"
let $REPORTFILE = "$HOME/notes/mod_report.txt"
let $SNIPPETDIR = "$HOME/.vim/config/snippets/"

if executable("rg")
  let &grepprg='rg --vimgrep -H --no-heading --ignore-file $HOME/.rg/ignore'
endif
"}}}

"status line{{{
set statusline=
set statusline+=%2*
set statusline+=%t
set statusline+=%0*
set statusline+=%r%w
set statusline+=%1*
set statusline+=%m
"readonly?
set statusline+=%r
"help?
set statusline+=%h
set statusline+=%0*

set statusline+=%=
set statusline+=%0*
set statusline+=%1*
set statusline+=%{grepper#statusline()}
"set statusline+=%{tagbar#currenttag('%s','')}
set statusline+=%0*
set statusline+=[%{&fileencoding}]
set statusline+=[%{&ff=='mac'?'CR':&ff=='unix'?'LF':'CRLF'}]
set statusline+=%1*
set statusline+=%0*
set statusline+=%5.l/%L
"}}}

"mappings{{{
let mapleader = ';' "Leader
"save
nnoremap <leader>s :w<CR>
"xで削除したらブラッホールにぶちこむ
nnoremap x "_x
nnoremap gR :Grepper-query<CR>
" nnoremap gR :Grepper-query expand("<cword>")
"次のバッファ
nnoremap <silent> ]b :bnext<CR>
"前のバッファ
nnoremap <silent> [b :bprevious<CR>
"次のタブ
nnoremap <silent> ]t :tabnext<CR>
"前のタブ
nnoremap <silent> [t :tabprevious<CR>
"Quickfixlist
nnoremap <leader>ee :call QFixToggle()<CR>:wincmd=<CR><CR>
"no higlight
nnoremap <F3> :noh<CR><CR>
"vimrcを縦スプリットで開く
nnoremap <leader>ev :vs $MYVIMRC<CR><CR>
"~/.tmux.confを縦スプリットで開く
nnoremap <leader>tc :vs $TMUXCONF<CR><CR>
"vimrcを再読み込みする
nnoremap <F12> :source $MYVIMRC<CR>:call PhpSyntaxOverride()<CR><CR>
"mod_report.txtを縦スプリットで開く
nnoremap <leader>mf :call system('tmux new-window')<CR><CR>
"Tagbarトグル tagbar pop
nnoremap tp :TagbarToggle<CR>
"currenttagコピー
nnoremap <leader>ct :let @+=expand(tagbar#currenttag('%s',''))<CR>
"statuslineにcurrenttag表示
nnoremap <leader>tt :call EnableStatusLineCurrentTag()<CR>
"currenttagのファンクション名でgrep look-functionとか?...
nnoremap <leader>lf :call GrepCurrentFunc()<CR>
"ファイル名をクリップボードにコピー
nnoremap <leader>cn :let @+ = expand('%')<CR>
"gs : gf縦分割バージョン
nnoremap gs :vertical wincmd f<CR>
"sort u
vnoremap <leader>s :sort u<CR>
"run script
nnoremap <leader>rs :call RunScript()<CR><CR>
"align docs
vnoremap ad :!column -t -s " " \| sed 's/^/ /'<CR><CR>
"phpdoc
nnoremap <leader>dc :call PhpDocSingle()<CR>
"add / on top of line on VisualMode
vnoremap p !sed 's/^/\//'<CR>
"change word by register0 word
nnoremap <leader>x cw<c-r>0
"go to abs path file
nnoremap gaf :<C-u>call GotoFileFromDocRoot()<CR>
nnoremap gef :<C-u>call GotoEntFile()<CR>
"var_dump($phpvariable);
nnoremap vr :call VarDumpPhpVariable()<CR>
"pre($phpvariable);
nnoremap vp :call PrePhpVariable()<CR>
"console log js variable
nnoremap cv :call ClogVar()<CR>
"disable built-in help(hacky){{{
nmap <F1> :echo<CR>
imap <F1> <C-o>:echo<CR>
"}}}
"ale previous
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
"ale next
nmap <silent> <C-j> <Plug>(ale_next_wrap)
"compile c and run the bin
nnoremap <F9> :call RunC()<CR>
"prepare grep command
nnoremap ff :Grepper<CR>
"+ buffer size vertically
nnoremap <S-h> :vert resize +15<CR>
"- buffer vertically
nnoremap <S-l> :vert resize -15<CR>
nnoremap <F5> :cnext<CR>
nnoremap <S-F5> :cprevious<CR>
"search by register "
nnoremap <F6> /<c-r>"<CR>
"identify hilight under cursor
nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
"fzf
nnoremap <c-space> :Buffers<CR>
nnoremap <c-p> :Files<CR>
nnoremap <c-h> :Hist<CR>
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <leader>gct :!/usr/local/bin/ctags -R --options=$HOME/.ctags<CR>

nnoremap <leader>gpt :!php ~/phpctags/phpctags.phar -R --kinds=dficpmnt<CR>
nnoremap <leader>fn :let @+=expand("%")<CR>
nnoremap <leader>bk :call CopyToDesktop()<CR>

"}}}

"abbrevations{{{
"htmlspecialchars -> hsc
ia hsc <c-r>="htmlspecialchars("<CR>
"var_dump
ia vd <c-r>="var_dump("<CR>
"current date
ia cdt <c-r>=strftime("%Y/%m/%d")<CR>
"c basic header files
ia chdr <c-r>="#include <stdio.h>\n\nint main(int argc, char *argv[]){\n}"<CR>
ia hlw <c-r>="hello,world!"<CR>
ia jvz <c-r>="javascript:void(0);"<CR>
ia shb <c-r>="#!/bin/bash"<CR>
"abbrevations}}}

"vim-plug{{{
call plug#begin('~/.local/share/nvim/plugged')
Plug 'StanAngeloff/php.vim'
Plug 'heavenshell/vim-jsdoc'
Plug 'junegunn/vim-easy-align'
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/PDV--phpDocumentor-for-Vim'
Plug 'vim-scripts/httplog' "usage: setf httplog
Plug 'vim-scripts/tagbar-phpctags'
Plug 'w0rp/ale'
Plug 'will133/vim-dirdiff'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'skreek/skeletor.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': { -> coc#util#install()}}
Plug 'mhinz/vim-grepper'
Plug 'triglav/vim-visual-increment'
Plug 'vim-python/python-syntax'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'markonm/traces.vim'
call plug#end()
"}}}

"plugin settings{{{
"----------------------------------------
" Emmet
"----------------------------------------
let g:user_emmet_leader_key='<c-e>'
let g:user_emmet_settings = {
    \    'variables': {
    \      'lang': "ja"
    \    },
    \   'indentation': '  '
    \ }
"----------------------------------------
" EasyAlign
"----------------------------------------
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" ignore nothing
let g:easy_align_ignore_groups = []
"----------------------------------------
" Tagbar
"----------------------------------------
let g:tagbar_autofocus = 0
let g:tagbar_compact = 0
let g:tagbar_singleclick = 1
let g:tagbar_sort = 0
let g:tagbar_indent = 0
let g:tagbar_autopreview = 0
let g:tagbar_iconchars = ['▸', '▾']
let g:tagbar_silent = 1
let g:tagbar_left = 0
let g:tagbar_width = 36
let g:tagbar_type_php  = {
    \ 'kinds'     : [
        \ 'i:interfaces',
        \ 'c:classes',
        \ 'f:functions',
   \ ]
  \ }
"----------------------------------------
" pdv
"----------------------------------------
let g:pdv_cfg_Type = "string"
let g:pdv_cfg_Package = ""
let g:pdv_cfg_Version = "$id$"
let g:pdv_cfg_Author = ""
let g:pdv_cfg_Copyright = ""
let g:pdv_cfg_License = ""
let g:pdv_cfg_Access = ""
let g:pdv_cfg_php4always = 0
let g:pdv_cfg_Uses       = 0
let g:pdv_cfg_php4always = 0
let g:pdv_cfg_php4guess  = 0
"----------------------------------------
" php.vim
"----------------------------------------
let g:php_html_load = 0
let g:php_html_in_heredoc = 0
let g:php_html_in_nowdoc = 0
let g:php_var_selector_is_identifier= 1
let g:php_baselib = 1
let g:php_parent_error_close = 0
let g:php_parent_error_open = 0
let g:php_sql_query = 1
let g:php_folding = 0
let g:php_sql_heredoc = 0
let g:php_sql_nowdoc = 0
"----------------------------------------
" commentary
"----------------------------------------
autocmd FileType php setlocal commentstring=//\ %s
"----------------------------------------
" ALE
"----------------------------------------
let g:ale_linters = {'php': ['phpmd','php'], 'javascript': ['jshint'] , 'haskell' : []}
let g:ale_php_phpmd_use_global = 1
let g:ale_php_phpmd_ruleset = 'unusedcode'
let g:ale_php_phan_use_global = 1
let g:ale_sign_column_always = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_insert_leave = 1
let g:ale_set_balloons = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 1
let g:ale_lint_on_filetype_changed = 0
"----------------------------------------
" tagbar-phpctags
"---------------------------------------
let g:tagbar_phpctags_bin = '~/phpctags/phpctags.phar'
"----------------------------------------
" phpcomplete
"---------------------------------------
let g:phpcomplete_complete_for_unknown_classes = 0
"-----------------------------------------
" sorround
"-----------------------------------------
let g:surround_{char2nr('q')} = "\\\"\r\\\""
"-----------------------------------------
" lightline
"-----------------------------------------
function! GrepperStatus()
 return grepper#statusline()
endfunction

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'right': [ [ 'mylineinfo' ], [ 'grepperstatus', 'myfileformatinfo', 'fileencoding', 'filetype' ] ],
      \ },
      \ 'component_function': {
      \   'myfileformatinfo': "MyFileformatInfo",
      \   'mylineinfo': "MyLineinfo",
      \   'currentfunction': 'CocCurrentFunction',
      \   'grepperstatus': 'GrepperStatus'
      \ },
      \ 'separator': { 'left': "\ue0b0", 'right': "" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
      \ }
"-----------------------------------------
" lightline_foobar
"-----------------------------------------
let g:lightline.colorscheme = 'palenight_alter'
"-----------------------------------------
" Grepper
"-----------------------------------------
let g:grepper = {}
let g:grepper.rg = {
    \'grepprg': 'rg --vimgrep --ignore-file $HOME/.rg/ignore',
    \ 'grepformat': '%f:%l:%m',
    \ 'escape':     '\^$.*[]',
    \ }

let g:grepper.tools = ['rg']
let g:grepper.highlight = 1
let g:grepper.jump = 0
let g:grepper.prompt_text = '$c> '
let g:grepper.prompt_quote = 0
let g:grepper.switch = 0

"-----------------------------------------
" UltiSnips
"-----------------------------------------
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories=[$HOME . '/.vim/config/snippets']
"-----------------------------------------
"}}}

"functions{{{
"今いるファンクション名でgrep
function! GrepCurrentFunc()
	let l:func_name= expand(tagbar#currenttag('%s',''))
	execute 'Grepper-query "'.l:func_name.'"'
endfunction

"全角スペースをハイライト表示
function! ZenkakuSpace()
    highlight ZenkakuSpace guibg=purple
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme       * call ZenkakuSpace()
        autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    augroup END
    call ZenkakuSpace()
endif

"現在のファイルをインタプリタで実行
function! RunScript()
	"haskellならghcのインタプリタ
	if expand('%:e') == "hs"
		let l:bin = "runghc"
	else
	"それ以外なら拡張子そのままをコマンド
		let l:bin = expand('%:e') 
	endif
	let l:file = expand('%')
	execute ':vnew | 0read ! '. l:bin .' #'
endfunction

function! PhpSyntaxOverride()
  hi! phpVarSelector guifg=#ffcb6b guibg=#1E1E28 cterm=NONE
  hi! link phpIdentifier phpVarSelector
  hi! link phpDocTags phpDefine
  hi! link phpDocParam phpType
endfunction

"docrootからのパスで開く
function! GotoFileFromDocRoot()
    let root_dir = getcwd() . "/"
    let filename = getline('.')
    let filepath = root_dir . filename
    if filereadable(filepath)
        execute 'edit ' . filepath
    else
        echohl ErrorMsg
        echo 'ファイルが見つかりませんでした!  ---> ' . filename
        echohl None
    endif
endfunction

function! GotoEntFile()
    let filename = getline('.')
    let filepath = "/d/workspace/surala" . filename
    if filereadable(filepath)
        execute 'edit ' . filepath
    else
        echohl ErrorMsg
        echo 'ファイルが見つかりませんでした!  ---> ' . filename
        echohl None
    endif
endfunction

function! VarDumpPhpVariable()
  let @* = "var_dump(" . expand('<cword>') . "); //########## TODO kimura ".strftime("%Y/%m/%d")." ##########"
endfunction

function! PrePhpVariable()
  let @* = "pre(" . expand('<cword>') . "); //########## TODO kimura ".strftime("%Y/%m/%d")." ##########"
endfunction

function! ClogVar()
  let @* = "console.log(\"" . expand('<cword>') . ":\", " . expand('<cword>') . "); //########## TODO kimura ".strftime("%Y/%m/%d")." ##########"
endfunction

function! QFixToggle()
  let _ = winnr('$')
    cclose
  if _ == winnr('$')
    cwindow
  endif
endfunction

function! RunC()
  if (&filetype == "c")
   execute '!gcc '.expand('%').' && ./a.out'
  else
   echohl WarningMsg | echo 'cannot run. not a c file.'
  endif
endfunction


function! OpenWinExplorer()
  call system('explorer.exe .')
endfunction

function! CopyIntoOrgDir(newName)
	let l:cmd = 'cp ' . expand('%') . ' ' . expand('%:h') . '/'. a:newName
	echo l:cmd
	call system(l:cmd)
	execute 'edit ' . expand('%:h') . '/'. a:newName
endfunction

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

command! LightlineReload call LightlineReload()

function! LightlineReload()
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

function! MyLineinfo()
  return line('.') . '/' . line('$')
endfunction

function! MyFileformatInfo()
  return &ff=='mac'?'mac[CR]':&ff=='unix'?'unix[LF]':'dos[CRLF]'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! CopyToDesktop()
  let l:cmd = "cp ".expand("%")." /c/Users/kimura.AZET/Desktop/".expand("%:t").".bak.".strftime("%Y%m%d")
  echo l:cmd
  call system(l:cmd)
endfunction

function! FJumpUp()
 normal [[
 call histdel("/")
 " call histdel("search", -1)
endfunction

"}}}

"auto command {{{
"phpシンタックス上書き
augroup phpSyntaxOverride
  autocmd!
  autocmd FileType php call PhpSyntaxOverride()
augroup END

" インサートモードから抜けたらIMEを英語にセット
augroup reset_ime
  au!
  au InsertLeave * set iminsert=0
augroup END

"リサイズ時に画面幅をそろえる
augroup Misc
    autocmd!
    autocmd VimResized * exe "normal! \<c-w>="
augroup END

" push quickfix window always to the bottom
autocmd FileType qf wincmd J

autocmd FileType haskell set tabstop=4|set shiftwidth=4|set expandtab
autocmd FileType vim set tabstop=2|set shiftwidth=2|set expandtab
autocmd FileType php set noexpandtab

"phpは$をキーワードとしてあつかう wで $variable 全体がとれるように
autocmd FileType php :setlocal iskeyword+=$

" WSL ヤンクでクリップボードにコピー
if system('uname -a | grep Microsoft') != ''
  augroup myYank
    autocmd!
    autocmd TextYankPost * :call system('clip.exe', @")
  augroup END
endif
"}}}

"read external files {{{
if filereadable(expand($PRJCONF)) | source $PRJCONF | endif
if filereadable(expand($MYVIMRC2)) | source $MYVIMRC2 | endif
"}}}

colorscheme palenight
set foldmethod=marker
"auto open folds
autocmd FileType php normal zR

nnoremap <Leader>F :FZF -q <C-R><C-W><CR>

"TODO
" let g:loaded_python_provider = 1
" let g:python_host_skip_check=1
" let g:python_host_prog = '/usr/local/bin/python'
" let g:python3_host_skip_check=1
" let g:python3_host_prog = '/usr/local/bin/python3'
