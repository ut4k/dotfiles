if filereadable(expand("~/.vim/config/srl.vim"))
 runtime! config/srl.vim
endif

"runtime! config/srl.vim

"global variables{{{
"auto highlight same words - 1:disable, 0:enable
let g:toggleHighlight = 1
"}}}

"mappings{{{
let mapleader = ','
nnoremap gR :Grep "\<<cword>\>" *<CR>
"]b : 次のバッファ
nnoremap <silent> ]b :bnext<CR>
"[b : 前のバッファ
nnoremap <silent> [b :bprevious<CR>
"F2 : QuickFixリスト
nnoremap <F2> :cclose<CR>:copen<CR>:wincmd=<CR><CR>
nnoremap <F4> :cclose<CR>:vert :copen<CR>:wincmd=<CR><CR>
"F3 : no higlight
nnoremap <F3> :noh<CR><CR>
",ev : _vimrcを縦スプリットで開く
"nnoremap <Leader>ev :vsplit $MYVIMRC<CR><CR>
nnoremap <Leader>ev :e $MYVIMRC<CR><CR>
"F12 : MY(G)VIMRCを再読み込みする
nnoremap <F12> :<C-u>source $MYVIMRC<CR>
"Tagbarトグル
nnoremap <Leader>tb :TagbarToggle<CR>
"Colorizerのトグル
nnoremap <Leader>tcr :ColorToggle<CR>
"currenttagコピー
nnoremap <Leader>ct :let @+=expand(tagbar#currenttag('%s\(\)',''))<CR>
"currenttagのファンクション名でgrep look-functionとか?...
nnoremap <Leader>lf :call GrepCurrentFunc()<CR>
"ファンクションリスト
nnoremap <leader>ff :call FunctionsList()<CR>
"上のファンクションの宣言にジャンプ
nnoremap <buffer> <up> :call FunctionJumpUp()<CR>
"下のファンクションの宣言にジャンプ
nnoremap <buffer> <down> :call FunctionJumpDown()<CR>
"ファイル名をクリップボードにコピー
nnoremap <leader>cn :let @+ = expand('%')<CR>
"gs : gf縦分割バージョン
nnoremap gs :vertical wincmd f<CR>
"php-cs-fixer コーディング規則にそって整形
nnoremap <leader>pcf :!php-cs-fixer fix % --rules=@PSR2<CR>
"generate ctags
nnoremap <leader>gct :!ctags -R --exclude=.svn --exclude=node_modules --exclude=_test --exclude=smarty --exclude="*.min.*" --exclude=.git --langmap=php:.php.inc --PHP-kinds=+cf-v<CR>
"list up buffer
nnoremap <leader>, :CtrlPBuffer<CR>
"vertical +50
nnoremap <leader>+ :vertical resize +50<CR>
"vertical -50
nnoremap <leader>- :vertical resize -50<CR>
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
"自動単語ハイライトONOFF
nnoremap <F11> :call ToggleHighlight(1)<CR>
"open tagjump in new tab
"nnoremap <C-]> :tab tjump <C-r><C-w><CR>
nnoremap <C-]> :tjump <C-r><C-w><CR>
"add only debug!! text to end of the line
"nnoremap <leader>n
nnoremap <leader>dc :call PhpDocSingle()<CR>
vnoremap p !sed 's/^/\//'<CR>
"change word by register0 word
nnoremap <leader>cr cw<c-r>0
nnoremap <C-n> :NERDTreeToggle<CR>
"}}}

"abbrevations{{{
"htmlspecialchars -> hsc
ia hsc <c-r>="htmlspecialchars("<CR>
"var_dump
ia vd <c-r>="var_dump("<CR>
"current date
ia cdt <c-r>=strftime("%Y/%m/%d")<CR>
"current hms 
ia hms <c-r>=strftime("%Y/%m/%d %H:%M")<CR>
ia jsfor <c-r>="for(var i = 0; i < elm.length; i++){"<CR>
"abbrevations}}}

"basic{{{
language en_US.utf8
scriptencoding utf-8
set encoding=utf-8
set t_Co=256
autocmd ColorScheme * highlight User1 ctermfg=209 ctermbg=235
autocmd ColorScheme * highlight User2 ctermfg=209 ctermbg=235
set mouse=a

"Leave insert mode quickly
if ! has('gui_running')
	set ttimeoutlen=10
	augroup FastEscape
		autocmd!
		au InsertEnter * set timeoutlen=0
		au InsertLeave * set timeoutlen=1000
	augroup END
endif
"for cygwin
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

set background=dark
set t_Co=256
set backspace=indent,eol,start

"grep設定
command! -nargs=+ Grep execute 'silent !sh ~/myscript/greplogo.sh' | execute 'silent grep! <args>'| execute 'silent !clear' |:redraw!
autocmd QuickFixCmdPost *grep* cwindow
set grepprg=grep\ -rn\ --color=never\ --exclude-dir=smarty\ --exclude-dir=templates_c\ --exclude-dir=cache\ --exclude-dir=.svn\ --exclude-dir=.git\ --exclude=tags\ --exclude=.htaccess
set clipboard=unnamed,autoselect
set title
set titlestring=%{expand('%:p')}
set hlsearch
set nowrap
set smartcase
set termguicolors
colorscheme skeletor
autocmd ColorScheme * highlight User1 ctermfg=209 ctermbg=235
autocmd ColorScheme * highlight User2 ctermfg=209 ctermbg=235
augroup Misc
    autocmd!
    autocmd VimResized * exe "normal! \<c-w>="
augroup END
set ignorecase
set list
set listchars=tab:»\ ,precedes:«,extends:»,eol:↲
set ambiwidth=single
"set ambiwidth=double
set tabstop=2
set shiftwidth=2
set noundofile
set showmode
set number
set noruler
set nobackup
set noswapfile
set autoread
set hidden
set showcmd
set showmatch
set laststatus=2
set foldmethod=marker
set lazyredraw
set cursorline
set regexpengine=1 "正規表現エンジン 0か1
set splitright
source $VIMRUNTIME/macros/matchit.vim
"ワイルドカードで検索除外
set wildignore+=*\\.git\\*,*\\.hg\\*,*\\.svn\\*
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.jpg,*.png,*.gif,*.jpeg,*.swf
" インサートモードから抜けたらIMEを英語にセット
augroup reset_ime
	au!
	au InsertLeave * set iminsert=0
augroup END
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
set statusline+=%2*
set statusline+=%{tagbar#currenttag('%s\(\)\ ','')}
set statusline+=%0*
set statusline+=[%{&fileencoding}]
set statusline+=[%{&ff=='mac'?'CR':&ff=='unix'?'LF':'CRLF'}]
set statusline+=%0*
set statusline+=\ [%{current_project}]
set statusline+=%5.l/%L
"}}}
"}}}

"vim-plug{{{
call plug#begin('~/.vim/plugged')
Plug 'aklt/plantuml-syntax'
Plug 'chrisbra/Colorizer'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/vim-easy-align'
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
Plug 'qpkorr/vim-bufkill'
Plug 'tpope/vim-surround'
Plug 'vim-syntastic/syntastic'
"colorscheme-switcherとmiscはセットで使用
Plug 'xolox/vim-colorscheme-switcher'
Plug 'xolox/vim-misc'
Plug 'tpope/vim-unimpaired'
Plug 'kshenoy/vim-signature'
"for php
Plug 'nrocco/vim-phplint'
Plug 'StanAngeloff/php.vim'
Plug 'alvan/vim-php-manual'
Plug 'vim-scripts/PDV--phpDocumentor-for-Vim'
Plug 'kana/vim-arpeggio'
Plug 'tpope/vim-commentary'
Plug 'will133/vim-dirdiff'
Plug 'scrooloose/nerdtree'
Plug 'jreybert/vimagit'
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
" PlantUML
"----------------------------------------
let g:plantuml_executable_script='C:/cygwin64/home/Kimura/plantuml/plantuml.sh'
"----------------------------------------
" Tagbar
"----------------------------------------
let g:tagbar_autofocus = 0
"let g:tagbar_show_linenumbers = 1
 let g:tagbar_type_php  = {
    \ 'ctagstype' : 'php',
    \ 'kinds'     : [
        \ 'i:interfaces',
        \ 'c:classes',
        \ 'd:constant definitions',
        \ 'f:functions',
        \ 'j:javascript functions:1'
    \ ]
  \ }
"----------------------------------------
" Vimux
"----------------------------------------
let g:VimuxUseNearest = 0
let g:VimuxRunnerType = "window"
"----------------------------------------
" Syntastic
"----------------------------------------
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_php_phpcs_exec='C:/xampp/php/phpcs'
let g:syntastic_php_checkers = ['php']
let g:syntastic_php_phpcs_args = "--standard=psr2"
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
"}}}

" functions{{{
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
	execute 'silent grep! '.l:func_name.' |:redraw!'
endfunction

"全角スペースをハイライト表示
"undercurlはGVIMでしか使えない!!
function! ZenkakuSpace()
    "highlight ZenkakuSpace cterm=underline ctermfg=121 ctermbg=233
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
  else
    call clearmatches()
  endif
endfunction

autocmd CursorMoved * call ToggleHighlight()

function! MySearch(myVar)
    let @/=a:myVar
endfunction

function! PhpSyntaxOverride()
  " Put snippet overrides in this function.
  hi! link phpDocTags phpDefine
  hi! link phpDocParam phpType
endfunction
"}}}

"auto command group {{{
augroup phpSyntaxOverride
  autocmd!
  autocmd FileType php call PhpSyntaxOverride()
augroup END
"}}}
