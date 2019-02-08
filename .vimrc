"this needs to be on top ???{{{
autocmd ColorScheme * highlight User1 ctermbg=black ctermfg=121 cterm=bold
"}}}


"basic{{{
"winのときだけ言語enにする
if has("win32unix")
	language en_US.UTF-8
endif

scriptencoding utf-8
set encoding=utf-8

set termguicolors
set background=dark
set t_Co=256
colorscheme skeletor
set redrawtime=20000
set ttyfast
set updatetime=200

set ignorecase
set list
set listchars=tab:»\ ,precedes:«,extends:»,eol:↲
set ambiwidth=single
"set ambiwidth=double

set mouse=a
set ttimeoutlen=10
set backspace=indent,eol,start
set clipboard=unnamed,autoselect

set autoread
set cursorline
set foldmethod=marker
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
set regexpengine=1 "正規表現エンジン 0か1
set shiftwidth=2
set showcmd
set showmatch
set showmode
set smartcase
set splitright
set tabstop=2
set title
set titlestring=%{expand('%:p')}

"ワイルドカードで検索除外
set wildignore+=*\\.git\\*,*\\.hg\\*,*\\.svn\\*
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.jpg,*.png,*.gif,*.jpeg,*.swf
set wildignore+=*/.git/*,*/tmp/*,*.swp

if has("win32unix")
	"for cygwin
	let &t_ti.="\e[1 q"
	let &t_SI.="\e[5 q"
	let &t_EI.="\e[1 q"
	let &t_te.="\e[0 q"
endif

let g:sql_type_default = 'mysql'

"html output
let g:html_number_lines = 0
let g:html_ignore_folding = 1
let g:html_font = "Consolas"


"diff setting
if &diff                             " only for diff mode/vimdiff
  set diffopt=filler,context:1000000 " filler is default and inserts empty lines for sync
endif
"}}}

"status line{{{
"left
set statusline=
set statusline+=%t
set statusline+=%r%w
set statusline+=%1*
set statusline+=%m
set statusline+=%0*
"right
set statusline+=%=
set statusline+=%0*
set statusline+=%1*
set statusline+=%{tagbar#currenttag('%s','')}
set statusline+=%0*
set statusline+=[%{&fileencoding}]
set statusline+=[%{&ff=='mac'?'CR':&ff=='unix'?'LF':'CRLF'}]
set statusline+=%1*
" if exists('current_project')
"   set statusline+=\ [%{current_project}]
" endif
set statusline+=%0*
set statusline+=%5.l/%L
"}}}
"
"mappings{{{
let mapleader = ';' "Leader

"xで削除したらブラッホールにぶちこむ
nnoremap x "_x
nnoremap gR :Grep "<cword>"<CR>
"次のバッファ
nnoremap <silent> ]b :bnext<CR>
"前のバッファ
nnoremap <silent> [b :bprevious<CR>
"次のタブ
nnoremap <silent> ]t :tabnext<CR>
"前のタブ
nnoremap <silent> [t :tabprevious<CR>
"Quickfixlist
nnoremap ;ee :call QFixToggle()<CR>:wincmd=<CR><CR>
"no higlight
nnoremap <F3> :noh<CR><CR>
"vimrcを縦スプリットで開く
nnoremap <Leader>ev :e $MYVIMRC<CR><CR>
"vimrcを再読み込みする
nnoremap <F12> :source $MYVIMRC<CR>
"Tagbarトグル tagbar pop
nnoremap tp :TagbarToggle<CR>
"currenttagコピー
nnoremap <Leader>ct :let @+=expand(tagbar#currenttag('%s',''))<CR>
"currenttagのファンクション名でgrep look-functionとか?...
nnoremap <Leader>lf :call GrepCurrentFunc()<CR>
"上のファンクションの宣言にジャンプ
nnoremap <buffer> <up> :call FunctionJumpUp()<CR>
"下のファンクションの宣言にジャンプ
nnoremap <buffer> <down> :call FunctionJumpDown()<CR>
"ファイル名をクリップボードにコピー
nnoremap <leader>cn :let @+ = expand('%')<CR>
"gs : gf縦分割バージョン
nnoremap gs :vertical wincmd f<CR>
"sort u
vnoremap <leader>s :sort u<CR>
"run script
nnoremap <leader>rs :call RunScript()<CR><CR>
"align docs
vnoremap ad :!column -t -o " " \| sed 's/^/ /'<CR><CR>
"mark列表示
nnoremap <leader>x :SignatureToggle<CR>
"backward loop whileかforeachかforを前方検索で探す
nnoremap <leader>bl ?\(while\\|foreach\\|for\)<CR>
"phpdoc
nnoremap <leader>dc :call PhpDocSingle()<CR>
"add / on top of line on VisualMode
vnoremap p !sed 's/^/\//'<CR>
"change word by register0 word
nnoremap <leader>cw cw<c-r>0
"go to abs path file
nnoremap gaf :<C-u>call GotoFileFromDocRoot()<CR>
"php variable var_dump strin into regester
nnoremap vr :call VdVar()<CR>
"console log js variable
nnoremap cvr :call ClogVar()<CR>
"tagjump
nnoremap <c-]> :CtrlPtjump<CR>
"serch php variable back
nnoremap vb :call BackSearchPhpVar()<CR>
"save
nnoremap ;w :w<CR>
"-- HACK disable built-in help
nmap <F1> :echo<CR>
imap <F1> <C-o>:echo<CR>
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
"compile c and run the bin
nnoremap <F9> :call RunC()<CR>
nnoremap <leader>D :Commentary<Esc>^$A dlsr
"prepare grep command
nnoremap ff :Grep ""<Left>
"open file dir in windows explorer
nnoremap <leader>we :call OpenWinExplorer()<Esc>
"+ buffer size vertically
nnoremap <S-h> :vert resize +15<CR>
"- buffer vertically
nnoremap <S-l> :vert resize -15<CR>
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
"abbrevations}}}

"vim-plug{{{
call plug#begin('~/.vim/plugged')
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/vim-easy-align'
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
Plug 'qpkorr/vim-bufkill'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'xolox/vim-colorscheme-switcher' "colorscheme-switcherとmiscはセットで使用
Plug 'xolox/vim-misc'
Plug 'tpope/vim-unimpaired'
Plug 'kshenoy/vim-signature'
Plug 'StanAngeloff/php.vim'
Plug 'alvan/vim-php-manual'
Plug 'vim-scripts/PDV--phpDocumentor-for-Vim'
Plug 'kana/vim-arpeggio'
Plug 'tpope/vim-commentary'
Plug 'will133/vim-dirdiff'
Plug 'robmiller/vim-movar'
Plug 'ivalkeen/vim-ctrlp-tjump'
Plug 'heavenshell/vim-jsdoc'
Plug 'pangloss/vim-javascript'
Plug 'vim-scripts/httplog' "setf httplog
Plug 'yous/vim-open-color'
Plug 'yuttie/comfortable-motion.vim'
Plug 'dag/vim2hs'
Plug 'itchyny/vim-haskell-indent'
Plug 'shawncplus/phpcomplete.vim'
Plug 'vim-scripts/tagbar-phpctags'
Plug 'Nequo/vim-allomancer'
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
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
"----------------------------------------
" CtrlP
"----------------------------------------
let g:ctrlp_use_caching = 1
let g:ctrlp_max_files  = 3000
let g:ctrlp_match_window = 'min:2,max:18,results=100,order:btt'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|svn|ico|swp|jpg|jpeg|png|gif|swf|uranai_lib/templates_c|ent)$'
let g:ctrlp_show_hidden = 0
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_lazy_update = 1
let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_current_file = 1
let g:ctrlp_cmd = 'CtrlPBuffer'
"----------------------------------------
" Tagbar
"----------------------------------------
let g:tagbar_autofocus = 0
let g:tagbar_compact = 1
let g:tagbar_singleclick = 1
let g:tagbar_sort = 0
let g:tagbar_indent = 2
let g:tagbar_autopreview = 0
let g:tagbar_iconchars = ['+', '-']
let g:tagbar_silent = 1
let g:tagbar_type_php  = {
    \ 'kinds'     : [
        \ 'i:interfaces',
        \ 'c:classes',
        \ 'f:functions',
        \ 'm:members:0:0',
        \ 'v:variables:0:0'
    \ ]
  \ }
"----------------------------------------
" pdv
"----------------------------------------
let g:pdv_cfg_Type = "mixed"
let g:pdv_cfg_Package = ""
let g:pdv_cfg_Version = "$id$"
let g:pdv_cfg_Author = ""
let g:pdv_cfg_Copyright = ""
let g:pdv_cfg_License = ""
let g:pdv_cfg_Access = ""
"----------------------------------------
" php.vim
"----------------------------------------
let g:php_html_load=1
let g:php_html_in_heredoc=1
let g:php_html_in_nowdoc=1
let g:php_var_selector_is_identifier=1
let g:php_baselib = 1
let g:php_parent_error_close = 1
let g:php_parent_error_open = 1
let g:php_sql_query = 1
"----------------------------------------
" commentary
"----------------------------------------
autocmd FileType php setlocal commentstring=//\ %s
"----------------------------------------
" arpeggio
"----------------------------------------
"jk or kj to escape
call arpeggio#load()
call arpeggio#map('i', '', 0, 'jk', '<Esc>')
call arpeggio#map('i', '', 0, 'kj', '<Esc>')
"----------------------------------------
" ALE
"----------------------------------------
let g:ale_linters = {'php': ['phpmd','php'], 'javascript': ['jshint'] , 'haskell' : []}
let g:ale_php_phpmd_use_global = 1
let g:ale_php_phpmd_ruleset = 'unusedcode'
let g:ale_php_phan_use_global = 1
let g:ale_sign_column_always = 1
"}}}

"functions{{{
"ctrlpbuffer時にctrl+@でカーソル下のバッファを閉じる
let g:ctrlp_buffer_func = { 'enter': 'CtrlPMappings' }
function! CtrlPMappings()
  nnoremap <buffer> <silent> <C-@> :call <sid>DeleteBuffer()<cr>
endfunction

function! s:DeleteBuffer()
  let path = fnamemodify(getline('.')[2:], ':p')
  let bufn = matchstr(path, '\v\d+\ze\*No Name')
  exec "bd" bufn ==# "" ? path : bufn
  exec "norm \<F5>"
endfunction

"今いるファンクション名でgrep
function! GrepCurrentFunc()
	let l:func_name=expand(tagbar#currenttag('%s',''))
	execute 'silent rg! '.l:func_name.' |:redraw!'
endfunction

"今ひらいているファイル名でgrep
function! GrepCurrentFile()
	let l:file_name=expand('%:t')
	echo l:file_name
endfunction

"全角スペースをハイライト表示
function! ZenkakuSpace()
    highlight ZenkakuSpace ctermbg=red
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme       * call ZenkakuSpace()
        autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    augroup END
    call ZenkakuSpace()
endif
"シモンさんからもらったやつ <3

"上のファンクションの宣言にジャンプする
function! FunctionJumpUp()
	" saving previous search
	let l:sch = @/
	let l:line = search("function", 'b')
	" restore search
	let @/ = l:sch
	normal zz
endfunction
"下のファンクションの宣言にジャンプする
function! FunctionJumpDown()
	" saving previous search
	let l:sch = @/
	let l:line = search("function")
	" restore search
	let @/ = l:sch
	normal zz
endfunction
"ファンクションをリストする
function! FunctionsList()
	let ok=1
	if (&filetype == "php")
		vimgrep /\<function\>.*(/j %
	elseif (&filetype == "javascript")
		" This is a lazy regex but it'll do for now!
		" also used to count functions in azet-comment.vin
		vimgrep /^\s*function/j %
	else
		echo "File type ".&filetype." not yet supported"
		let ok=0
	endif
	" TODO adding other file type support
	" finally showing the results
	if (ok==1)
		cw
	endif
endfunction
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
"行移動したらカーソル下ハイライト //switches behaviour by argument
function! ToggleHighlight(...)
  if a:0 == 1 "toggle behaviour
    let g:toggleHighlight = 1 - g:toggleHighlight
  endif

  if g:toggleHighlight == 0 "normal action, do the hi
    silent! exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))
    " silent! exe printf('match IncSearch //', escape(expand('<cword>'), '/\'))
  else
    call clearmatches()
  endif
endfunction

function! PhpSyntaxOverride()
  " Put snippet overrides in this function.
  hi! def link phpDocTags  phpDefine
  hi! def link phpDocParam phpType
  hi! phpFunctions ctermfg=121 ctermbg=NONE cterm=NONE
  hi! phpVarSelector ctermfg=229 ctermbg=NONE cterm=NONE
  hi! phpMemberSelector ctermfg=121 ctermbg=NONE cterm=NONE
  hi! link phpDocTags phpDefine
  hi! link phpDocParam phpType
endfunction

"docrootからのパスで開く
function! GotoFileFromDocRoot()
    let filename = getline('.')
    let filepath = g:root_dir . filename
    if filereadable(filepath)
        execute 'edit ' . filepath
    else
        echohl ErrorMsg
        echo 'ファイルが見つかりませんでした! ' . filename
        echohl None
    endif
endfunction

function! PreVar()
  let @* = "echo \"<small style=color:magenta>\\$" . expand('<cword>') . ":</small>\"; pre($" . expand('<cword>') . "); //########## debug kimura ".strftime("%Y/%m/%d")." ##########"
endfunction

function! VdVar()
  let @* = "echo \"<small>\\$" . expand('<cword>') . ":</small>\"; var_dump($" . expand('<cword>') . "); //########## debug kimura ".strftime("%Y/%m/%d")." ##########"
endfunction

function! BackSearchPhpVar()
	let l:w = "\$" . expand('<cword>')
	let @/=l:w
endfunction

function! ClogVar()
  let @* = "console.log(" . expand('<cword>') . "); //########## debug kimura ".strftime("%Y/%m/%d")." ##########"
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
	if has("win32unix")
		echo "opened " . expand('%:h')
		call system('cygstart ' . expand('%:h'))
	endif
endfunction

function! CopyIntoOrgDir(newName)
	let l:cmd = 'cp ' . expand('%') . ' ' . expand('%:h') . '/'. a:newName
	echo l:cmd
	call system(l:cmd)
	execute 'edit ' . expand('%:h') . '/'. a:newName
endfunction
"}}}

"my ex command {{{
"grep設定
command! -nargs=+ Grep execute 'silent !sh ~/myscript/greplogo.sh' | execute 'silent grep! <args>'| execute 'silent !clear' |:redraw! |:cfirst |:wincmd j
autocmd QuickFixCmdPost *grep* cwindow
"set grepprg=grep\ -rn\ --color=never\ --exclude-dir=smarty\ --exclude-dir=templates_c\ --exclude-dir=cache\ --exclude-dir=.svn\ --exclude-dir=.git\ --exclude=tags\ --exclude=.htaccess
" > Globs are interpreted in exactly the same way as .gitignore patterns. That is, later globs will override earlier globs.
if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading\ --sort-files\ --no-column\ --line-number\ --path-separator\ '/'\ --glob\ '!tags'\ --glob\ '!.svn'\ --glob\ '!*.min.css'\ --glob\ '!*.min.js'\ --glob\ '!jquery.js'\ --glob\ '!www/material/flash/*'
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
"}}}

"auto command {{{

"phpシンタックス上書き
augroup phpSyntaxOverride
  autocmd!
  autocmd FileType php call PhpSyntaxOverride()
augroup END

if has("win32unix")
	"cygwin用 モード切替のラグを減らす
	augroup FastEscape
		autocmd!
		au InsertEnter * set timeoutlen=0
		au InsertLeave * set timeoutlen=1000
	augroup END
endif

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
"spacing for Haskell
autocmd FileType haskell set tabstop=4|set shiftwidth=4|set expandtab

"}}}

"read external files {{{
if filereadable(expand("$HOME/.vim/config/srl.vim"))
 source $HOME/.vim/config/srl.vim
endif

source $VIMRUNTIME/macros/matchit.vim
"}}}
