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
set hidden " 保存されていないファイルがあるときでも別のファイルを開くことが出来る
set gdefault "global substitute by default /g option
set ignorecase
set smartcase
set list
set listchars=tab:»\ ,precedes:«,extends:»,eol:↲
set ambiwidth=double
set whichwrap+=h,l,<,>,[,],b,s "行間をでシームレスに移動する

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
let $BASH_ENV = "~/.bashrc" "load bash config

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
let g:html_font = "Terminus"

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
"}}}

"status line{{{
set statusline=
set statusline+=%2*
set statusline+=%{expand('%:.')}
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
set statusline+=%{NearestMethodOrFunction()}\  
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
"tag list pop
nnoremap tp :Vista!!<CR>
"ファイル名をクリップボードにコピー
nnoremap <leader>cn :let @+ = expand('%')<CR>
"ファンクション名をクリップボードにコピー
nnoremap <leader>ccf :call CopyCurrentFunctionName()<CR>
"gs : gf縦分割バージョン
" nnoremap gs :vertical wincmd f<CR>
"sort u
vnoremap <leader>s :sort u<CR>
"run script
nnoremap <leader>rs :call RunScript()<CR><CR>
nnoremap <leader>ts :call RunInTmux()<CR><CR>
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
"compile c and run the bin
nnoremap <F9> :call RunC()<CR>
"prepare grep command
nnoremap ff :Grepper<CR>
"+ buffer size vertically
nnoremap <S-h> :vert resize +15<CR>
"- buffer vertically
nnoremap <S-l> :vert resize -15<CR>
nnoremap <F5> :cnext<CR>
nnoremap <F6> :cprevious<CR>
"search by register "
nnoremap <leader>w /<c-r>"<CR>
"open in windows explorer
nnoremap <leader>ow :call WinExplorer()<CR>
"identify hilight under cursor
nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
"fzf
nnoremap <c-p> :Files<CR>
nnoremap <c-space> :Buffers<CR>
nnoremap <c-h> :Hist<CR>
"pass cursor word as fzf query
nnoremap <c-q> :call fzf#vim#files('.', {'options':'--query '.expand('<cword>')})<CR>
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <leader>gct :!/usr/local/bin/ctags -R --options=$HOME/.ctags<CR>
nnoremap <leader>fn :call FileNameToReg()<CR>
nnoremap <leader>am :call AddtoModFileList()<CR>

"exec grepper with file name as a query
nnoremap gF :call GrepByFileName()<CR>
"exec grepper with cursor word as a query
nnoremap gR :call GrepByCword()<CR>
"Grepper-stop
nnoremap gS :Grepper-stop<CR>

nnoremap <leader>bk :call CopyToDesktop()<CR>
"coc
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
"定義もとへ go definition
nmap <silent> gd <Plug>(coc-definition)
"使用箇所一覧を出す ごちゃごちゃするので未使用
" nmap <silent> gr <Plug>(coc-references)

"double click to jump function definition "termでもうごく
nmap <2-LeftMouse> :exe "tag ". expand("<cword>")<CR>
" nmap <c-]> g<c-]>

"バッファ状態をsessionに保存
nnoremap <leader>ms :mksession! ~/.vim_session <CR>
nnoremap <leader>lo :source ~/.vim_session <CR>

nnoremap <M-Up> :wincmd k<CR>
nnoremap <M-Down> :wincmd j<CR>
nnoremap <M-Left> :wincmd h<CR>
nnoremap <M-Right> :wincmd l<CR>

nnoremap <leader>ph :call PhpSyntaxOverride()<CR>

nnoremap <F8> :NextColorScheme<CR>:call PhpSyntaxOverride()<CR>
"}}}

"vim-plug{{{
call plug#begin('~/.local/share/nvim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/httplog' "usage: setf httplog
Plug 'will133/vim-dirdiff'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': { -> coc#util#install()}}
Plug 'mhinz/vim-grepper'
Plug 'triglav/vim-visual-increment'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'sheerun/vim-polyglot' "language pack
Plug 'markonm/traces.vim' "substitute
Plug 'liuchengxu/vista.vim'
Plug 'wesQ3/vim-windowswap'
Plug 'xolox/vim-misc' "vim-colorscheme-switcher dependency
Plug 'xolox/vim-colorscheme-switcher'
Plug 'blueyed/smarty.vim'
Plug 'justinmk/vim-dirvish'
"php
Plug 'StanAngeloff/php.vim'
Plug 'shawncplus/phpcomplete.vim'
Plug 'vim-scripts/PDV--phpDocumentor-for-Vim'
"javascript
Plug 'heavenshell/vim-jsdoc'
Plug 'pangloss/vim-javascript'
"python
Plug 'vim-python/python-syntax'
"colorscheme
Plug 'drewtempelmeyer/palenight.vim'
Plug 'skreek/skeletor.vim'
Plug 'liuchengxu/space-vim-dark'
Plug 'kjssad/quantum.vim'
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
" tagbar-phpctags
"---------------------------------------
let g:tagbar_phpctags_bin = '~/phpctags/phpctags.phar'
"-----------------------------------------
" sorround
"-----------------------------------------
let g:surround_{char2nr('q')} = "\\\"\r\\\""
"-----------------------------------------
" Grepper
"-----------------------------------------
let g:grepper = {}
let g:grepper.rg = {
    \'grepprg': 'rg --vimgrep --line-number --ignore-case --ignore-file $HOME/.rg/ignore',
    \ 'grepformat': '%f:%l:%m',
    \ 'escape':     '\^$.*[]',
    \ }

let g:grepper.tools = ['rg']
let g:grepper.highlight = 1
let g:grepper.jump = 1
let g:grepper.prompt_text = '$t> '
let g:grepper.prompt_quote = 1  "自動でクオーティングしたことにする
let g:grepper.switch = 1
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
" Vista
" Tagbarから乗り換え
"-----------------------------------------
" let g:vista_default_executive = "coc"
let g:vista_default_executive = "ctags"
let g:vista_ignore_kinds = ['Variable', 'variable']
let g:vista_cursor_delay = 200
let g:vista_sidebar_width = 55
" -----------------------------------------
" vim-colorscheme-switcher
" -----------------------------------------
let g:colorscheme_switcher_exclude_builtins=1
" -----------------------------------------
" phpcomplete
" -----------------------------------------
let g:phpcomplete_mappings = { 'jump_to_def':'<C-]>' }
"}}}

"functions{{{
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

"現在のファイルをインタプリタで実行
function! RunInTmux()
	"haskellならghcのインタプリタ
	if expand('%:e') == "hs"
		let l:bin = "runghc"
	else
	"それ以外なら拡張子そのままをコマンド
		let l:bin = expand('%:e') 
	endif
	let l:file = expand('%')
	execute '!tmux send-keys -t 1 "'.l:bin.' '.l:file.'" Enter'
endfunction


function! PhpSyntaxOverride()
  " hi! phpVarSelector guifg=#ffcb6b guibg=#1E1E28 cterm=NONE
  hi! link phpVarSelector SpecialChar
  hi! link phpIdentifier Identifier

  hi! link phpDocTags phpDefine
  hi! link phpDocParam phpType

  hi! link phpFunction Function
  hi! link phpFunctions Function
  hi! link phpMethod Function

  hi! link phpRegion phpClasses
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

function! CopyCurrentFunctionName()
  let @* = NearestMethodOrFunction()
  :call system('clip.exe', @*)
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

function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

function! ReadAsCP932()
  :e ++enc=cp932
endfunction

function! WinExplorer()
  let l:wpath = trim(system("wslpath -w " .expand("%:p")))
  let l:cmd = "/mnt/c/Windows/explorer.exe /select,\"" . l:wpath . "\""
  echo "opening ".l:wpath." ..."
  call system(l:cmd)
endfunction

function! FileNameToReg()
  let l:path = expand("%")
  if g:on_ent_dir == 1
    let l:path = "/ent/" . l:path
  endif
  let @+=l:path
endfunction

function! GrepByFileName()
  let l:current_file_name = expand("%:t") "tail modifier
  execute "Grepper -noprompt -query " . l:current_file_name
endfunction

function! GrepByCword()
  let l:cword = expand("<cword>")
  execute "Grepper -noprompt -query " . l:cword
endfunction

"変更ファイルのメモに今のファイルパス加える
"tmuxペイン0にvimが開いている必要あり
function! AddtoModFileList()
  let l:path = expand("%")
  if g:on_ent_dir == 1
    let l:path = "/ent/" . l:path
  endif
  call system("echo ".l:path." >> /mnt/d/notes/mod_report.txt")
  call system("tmux send-keys -t 0 :e! Enter S-g zz")
endfunction
"}}}

"custom command {{{
command! ReadAsCP932 :call ReadAsCP932()
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

"tab or space
autocmd FileType haskell set tabstop=4|set shiftwidth=4|set expandtab
autocmd FileType vim set tabstop=2|set shiftwidth=2|set expandtab
autocmd FileType php set noexpandtab
autocmd FileType json set tabstop=2|set shiftwidth=2|set expandtab
autocmd FileType sql set tabstop=4|set shiftwidth=2|set noexpandtab|set smarttab

"phpは$をキーワードとしてあつかう wで $variable 全体がとれるように
autocmd FileType php :setlocal iskeyword+=$

" WSL ヤンクでクリップボードにコピー
if system('uname -a | grep Microsoft') != ''
  augroup myYank
    autocmd!
    autocmd TextYankPost * :call system('clip.exe', @")
  augroup END
endif

augroup autoConvertHtml
    autocmd!
    autocmd BufWritePost suralanote.md | silent! call system("pandochtml ".expand("%")." > /dev/null")
augroup END
"}}}

"read external files {{{
if filereadable(expand($PRJCONF)) | source $PRJCONF | endif
if filereadable(expand($MYVIMRC2)) | source $MYVIMRC2 | endif
"}}}

"colorscheme
" colorscheme palenight
" colorscheme xcodedark
colorscheme quantum
set foldmethod=marker

"auto open folds
autocmd FileType php normal zR

autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

"===========================================
"experimental
"===========================================
