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
set redrawtime=20000
set ttyfast
set updatetime=200

set noignorecase
set list
set listchars=tab:»\ ,precedes:«,extends:»,eol:↲
set ambiwidth=single
" set ambiwidth=double

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
set statusline+=%0*
set statusline+=[%{&fileencoding}]
set statusline+=[%{&ff=='mac'?'CR':&ff=='unix'?'LF':'CRLF'}]
set statusline+=%1*
set statusline+=%0*
set statusline+=%5.l/%L
"}}}
"
"mappings{{{
let mapleader = ';' "Leader
"save
nnoremap <leader>s :w<CR>
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
nnoremap <leader>ee :call QFixToggle()<CR>:wincmd=<CR><CR>
"no higlight
nnoremap <F3> :noh<CR><CR>
"vimrcを縦スプリットで開く
nnoremap <leader>ev :e $MYVIMRC<CR><CR>
"vimrcを再読み込みする
nnoremap <F12> :source $MYVIMRC<CR>:call PhpSyntaxOverride()<CR>
"Tagbarトグル tagbar pop
nnoremap tp :TagbarToggle<CR>
"currenttagコピー
nnoremap <leader>ct :let @+=expand(tagbar#currenttag('%s',''))<CR>
"statuslineにcurrenttag表示
nnoremap <leader>tt :call EnableStatusLineCurrentTag()<CR>
"currenttagのファンクション名でgrep look-functionとか?...
nnoremap <leader>lf :call GrepCurrentFunc()<CR>
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
vnoremap ad :!column -t -s " " \| sed 's/^/ /'<CR><CR>
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
"var_dump($phpvariable);
nnoremap vr :call VarDumpPhpVariable()<CR>
"pre($phpvariable);
nnoremap vp :call PrePhpVariable()<CR>
"console log js variable
nnoremap cvr :call ClogVar()<CR>
"tagjump
" nnoremap <c-]> :CtrlPtjump<CR>
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
nnoremap ff :call GrepConfirm()<CR>
"open file dir in windows explorer
nnoremap <leader>we :call OpenWinExplorer()<Esc>
"+ buffer size vertically
nnoremap <S-h> :vert resize +15<CR>
"- buffer vertically
nnoremap <S-l> :vert resize -15<CR>
nnoremap <F5> :cnext<CR>
nnoremap <S-F5> :cprevious<CR>
nnoremap <F7> :set scb<CR>
nnoremap <S-F7> :set noscb<CR>
"search by register "
nnoremap <F6> /<c-r>"<CR>
"identify hilight under cursor
nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
"fzf
nnoremap <c-@> :FZF<CR>
nnoremap <c-p> :Buffers<CR>
nnoremap <c-h> :Hist<CR>
nnoremap <c-t> :Tags<CR>
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
call plug#begin('~/.vim/plugged')
Plug 'StanAngeloff/php.vim'
Plug 'alvan/vim-php-manual'
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'heavenshell/vim-jsdoc'
" Plug 'ivalkeen/vim-ctrlp-tjump'
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
Plug 'shawncplus/phpcomplete.vim'
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
" ignore nothing
let g:easy_align_ignore_groups = []
"----------------------------------------
" CtrlP
"----------------------------------------
let g:ctrlp_use_caching = 1
let g:ctrlp_max_files  = 3000
let g:ctrlp_match_window = 'min:2,max:21,results=100,order:btt'
let g:ctrlp_show_hidden = 0
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_lazy_update = 1
let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_current_file = 1
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_mruf_default_order = 1
let g:ctrlp_mruf_relative = 1
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
let g:tagbar_width = 55
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
let g:php_sql_query = 0
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
" ---------------------------------------
let g:tagbar_phpctags_bin = '~/phpctags/phpctags.phar'
"----------------------------------------
" phpcomplete
" ---------------------------------------
let g:phpcomplete_complete_for_unknown_classes = 0
"}}}

"functions{{{
"今いるファンクション名でgrep
function! GrepCurrentFunc()
	let l:func_name= expand(tagbar#currenttag('%s',''))
	execute 'Grep "'.l:func_name.'"'
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
"}}}

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
  " Put snippet overrides in this function.
  hi! def link phpDocTags  phpDefine
  hi! def link phpDocParam phpType
  hi! phpFunctions ctermfg=121 ctermbg=NONE cterm=NONE

  hi! phpVarSelector guifg=#A685C3 guibg=#1E1E28 cterm=NONE
  hi! phpIdentifier guifg=#F0DD8A guibg=#1E1E28 cterm=NONE

  hi! phpMemberSelector ctermfg=121 ctermbg=NONE cterm=NONE
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
        echo 'ファイルが見つかりませんでした! ' . filename
        echohl None
    endif
endfunction

function! VarDumpPhpVariable()
  let @" = "var_dump(" . expand('<cword>') . "); //########## TODO kimura ".strftime("%Y/%m/%d")." ##########"
endfunction

function! PrePhpVariable()
  let @" = "pre(" . expand('<cword>') . "); //########## TODO kimura ".strftime("%Y/%m/%d")." ##########"
endfunction

function! ClogVar()
  let @" = "console.log(" . expand('<cword>') . "); //########## TODO kimura ".strftime("%Y/%m/%d")." ##########"
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

function! GrepConfirm()
	:let inputtext = input("grep:")
	if inputtext == ""
	 return
	endif
	execute 'Grep "'.inputtext.'"'
endfunction

function! EnableStatusLineCurrentTag()
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
	set statusline+=%0*
	set statusline+=%5.l/%L
endfunction

function! Colors1()
	:so $VIMRUNTIME/syntax/colortest.vim
endfunction

function! Colors2()
	:so $VIMRUNTIME/syntax/hitest.vim
endfunction

"}}}

"my ex command {{{
"Grep
command! -nargs=+ Grep execute 'silent !sh ~/scripts/greplogo.sh' | execute 'silent grep! <args>'| execute 'silent !clear' |:redraw! |:cfirst |:wincmd j
autocmd QuickFixCmdPost *grep* cwindow
if executable("rg")
  let &grepprg="rg
                \ --vimgrep
                \ --no-heading
                \ --line-number
                \ --path-separator '/'
                \ --glob '!tags'
                \ --glob '!.svn'
                \ --glob '!*.min.css'
                \ --glob '!*.min.js'
                \ --glob '!jquery.js'
                \ --glob '!www/material/flash/*'
                \ --glob '!ent/*'
                \ --glob '!tags'
                \ --glob '!cgi-bin'
                \ --glob '!opt'
                \ --glob '!www/tegaki'
                \ --glob '!www/tegaki_v2'
                \"
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
"}}}

"auto command {{{

"phpシンタックス上書き
augroup phpSyntaxOverride
  autocmd!
  autocmd FileType php call PhpSyntaxOverride()
	call PhpSyntaxOverride()
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
if filereadable(expand("$HOME/.vim/config/srl.vim"))
 source $HOME/.vim/config/srl.vim
 nnoremap <leader>esr :e $HOME/.vim/config/srl.vim<CR><CR>
endif

source $VIMRUNTIME/macros/matchit.vim
"}}}

"highlight line number(without cursorline)
" hi clear CursorLine
" augroup CLClear
"     autocmd! ColorScheme * hi clear CursorLine
" augroup END

" augroup CLNRSet
"     autocmd! ColorScheme * hi CursorLineNR cterm=bold
" augroup END

"to enable termiguicolors in tmux
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

let g:surround_{char2nr('q')} = "\\\"\r\\\""

"netrw
" let g:netrw_liststyle=1
let g:netrw_liststyle=3
let g:netrw_banner=0
let g:netrw_sizestyle="H"
let g:netrw_timefmt="%Y/%m/%d(%a) %H:%M:%S"
let g:netrw_preview=1
let g:netrw_altv=1

colorscheme skeletor
