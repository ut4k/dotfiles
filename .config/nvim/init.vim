function! OnEntryDir()
 return 0
endfunction

"run auto-intall script {{{
if filereadable($HOME."/scripts/vim-setup.sh")
 let g:install_script_ret = system($HOME . "/scripts/vim-setup.sh")
 if g:install_script_ret != ""
  echo g:install_script_ret
  sleep 2
 endif
endif
"}}}
"global variable {{{
let $PRJCONF        = "$HOME/.vim/config/prj.vim"
let $PLUGCONF       = "$HOME/.vim/config/plugins.vim"
let $TMUXCONF       = "$HOME/.tmux.conf"
let $SNIPPETDIR     = "$HOME/.vim/config/snippets/"
let $IGNOREFILE     = "$HOME/ignore/ignore"
let $IGNOREFILE_ENT = "$HOME/ignore/ignore_ent"
"}}}
"read external files {{{
if filereadable(expand($PRJCONF)) | source $PRJCONF | endif
if filereadable(expand($PLUGCONF)) | source $PLUGCONF | endif
"}}}
"
if OnEntryDir() == 1
   let $IGNOREFILE = $IGNOREFILE_ENT
endif

"use fd for fzf.vim
" if filereadable("/usr/bin/fd")
if executable("fd")
 let $FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --ignore-file='.$IGNOREFILE
else
 echo "fdが見つかりません (sudo apt install fd-find)"
 " ln -s $(which fdfind) ~/.local/bin/fd
endif

"basic{{{
autocmd ColorScheme * highlight User1 guifg=#ffcb6b guibg=0 gui=bold
autocmd ColorScheme * highlight User2 guifg=#c792ea guibg=0

autocmd ColorScheme * highlight LspDiagnosticsSignError guibg=red
autocmd ColorScheme * highlight LspDiagnosticsSignHint guibg=red

scriptencoding utf-8
set encoding=utf-8

set cmdheight=1
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
set ambiwidth=double
set listchars=tab:»\ ,precedes:«,extends:»,eol:↲
"
" ファイルが変更されたら自動で再読み込み
set autoread
" neovim用fix
autocmd FocusGained * silent! checktime

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
set splitright
set tabstop=2
" set tabstop=4
set notitle
set tags=tags
let $BASH_ENV = expand("$HOME/.bashrc") "load bash config

"todo
syntax sync minlines=20000
set redrawtime=10000

"ワイルドカードで検索除外
set wildignore+=*\\.git\\*,*\\.hg\\*,*\\.svn\\*
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.jpg,*.png,*.gif,*.jpeg,*.swf
set wildignore+=*/.git/*,*/tmp/*,*.swp

set cscopequickfix=s+,c+,d+,i+,t+,e+,a+

"html output
let g:html_number_lines = 0
let g:html_ignore_folding = 1
let g:html_font = "Consolas"

"to enable termiguicolors in tmux
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

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
set statusline+=%2*
set statusline+=%1*
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
"delete without yanking
nnoremap x "_x
" replace currently selected text with default register without yanking it
vnoremap p "_dP
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
nnoremap <leader>ep :vs $PRJCONF<CR><CR>
nnoremap <leader>ex :vs $PLUGCONF<CR><CR>
"~/.tmux.confを縦スプリットで開く
nnoremap <leader>tc :vs $TMUXCONF<CR><CR>
"vimrcを再読み込みする
nnoremap <silent> <F12> :source $MYVIMRC<CR>
" nnoremap <silent> <F12> :source $MYVIMRC<CR>:call PhpSyntaxOverride()<CR><CR>
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
vnoremap <leader>p !sed 's/^/\//'<CR>
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
nnoremap ff :Rg<space>
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
nnoremap <c-z> :call fzf#vim#files('.', {'options':'--query '.expand('%:t')})<CR>
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <leader>gct :!/usr/local/bin/ctags -R --options=$HOME/.ctags<CR>
nnoremap <leader>fn :call FileNameToReg()<CR>
nnoremap <leader>fl :call FileNameLineToReg()<CR>
nnoremap <leader>am :call AddtoModFileList()<CR>

"grep
nnoremap gF :call GrepByFileName()<CR>
nnoremap gR :call GrepByCword()<CR>

nnoremap <leader>bk :call CopyToDesktop()<CR>
"ダブルクリックでワードコピー
nnoremap <silent> <2-LeftMouse> :call system('clip.exe', expand('<cword>'))<CR>:let @/=expand('<cword>')<CR>:set hls<CR>

" nnoremap <leader>ph :call PhpSyntaxOverride()<CR>
" nnoremap <F8> :NextColorScheme<CR>:call PhpSyntaxOverride()<CR>

"type javascript
nnoremap <leader>tj :set filetype=javascript<CR>
"type html
nnoremap <leader>th :set filetype=html<CR>
"Meta-e カレントバッファのphpコードを実行してvsplitで開く
nnoremap <M-e> :call EvalVnew('php')<CR>
"Tortoise SVNコミット guiポップアップ
nnoremap cm :call SvnCommitSrl()<CR>
"Tortoise SVNログ guiポップアップ
nnoremap <leader>sl :call SvnLogPop()<CR>
"Tortoise SVNリバート guiポップアップ
nnoremap <leader>rv :call SvnRevertSrl()<CR>
"ライブラリを開く openlib
nnoremap <leader>ol :call OpenLibSrl()<CR>
"入り口プログラムを開く openentry
nnoremap <leader>oe :call OpenEntrySrl()<CR>
"TODOをgrep
nnoremap <leader>gtd :Rg (debug\|TODO).*kimura<CR>
"fin debug comments
nnoremap <leader>fd /debug\\|TODO\s*\(start\\|end\)*\s*kimura<CR>
"find my comments
nnoremap <leader>fm /\(add\\|update\\|del\\|debug\\|TODO\)\s*\(start\\|end\)*\s*kimura<CR>
"et edited today 今日の編集コメントを検索
nnoremap <leader>et :let @t = strftime("%Y\\/%m\\/%d")<CR>/<C-R>t<CR>
"et edited yesterday 昨日の編集コメントを検索
nnoremap <leader>ey :let @t = strftime("%Y\\/%m\\/%d", localtime() - (60*60*24))<CR>/<C-R>t<CR>
"F11でターミナルモードを終了
tnoremap <F11> <C-\><C-n>
"ビジュアル選択をフォーマット
nnoremap <leader>gv :GraphvizCompile png<CR>:Graphviz png<CR>
nnoremap <leader>gv :GraphvizCompile png<CR>:Graphviz png<CR>

nnoremap <leader>ws :StripWhitespace<CR><CR>
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
let g:php_sql_query = 0
let g:php_folding = 0
let g:php_sql_heredoc = 0
let g:php_sql_nowdoc = 0
"----------------------------------------
" commentary
"----------------------------------------
autocmd FileType php setlocal commentstring=//\ %s
autocmd FileType smarty setlocal commentstring={*\ %s\ *}
autocmd FileType sql setlocal commentstring=--\ %s
"-----------------------------------------
" sorround
"-----------------------------------------
let g:surround_{char2nr('q')} = "\\\"\r\\\""
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
"-----------------------------------------
let g:vista_default_executive = "ctags"
let g:vista_ignore_kinds = ['Variable', 'variable']
let g:vista_cursor_delay = 100
let g:vista_sidebar_width = 55
let g:vista#renderer#enable_icon = 1
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_icon_indent = ['└ ', '│ ']

"fzf symbol
nnoremap <C-s> :Vista finder<CR>
" -----------------------------------------
" vim-colorscheme-switcher
" -----------------------------------------
let g:colorscheme_switcher_exclude_builtins=1
" -----------------------------------------
" phpcomplete
" -----------------------------------------
let g:phpcomplete_enhance_jump_to_definition = 1
" let g:phpcomplete_mappings = {
"    \ 'jump_to_def': '<C-]>',
"    \ 'jump_to_def_split': '<C-W><C-]>',
"    \ 'jump_to_def_vsplit': '<C-W><C-\>',
"    \ 'jump_to_def_tabnew': '<C-W><C-[>',
"    \}
" -----------------------------------------
"  fzf
" -----------------------------------------
" let g:fzf_preview_window = 'right:40%'
let g:fzf_preview_window = []
let g:fzf_prefer_tmux = 0
let g:fzf_layout = { 'down' : '~14%' }
" -----------------------------------------
"  gen_tags
" -----------------------------------------
" let g:gen_tags#ctags_auto_gen = 0
" let g:gen_tags#statusline = 0
" let g:gen_tags#gtags_default_map = 0
" let g:loaded_gentags#ctags = 1
" -----------------------------------------
"  vim-javascript
" -----------------------------------------
let g:javascript_plugin_jsdoc = 1
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

function! ToLF()
:e ++ff=unix
endfunction

"現在のファイルをインタプリタで実行
function! RunScript()
 "現在のバッファ
 let l:curbuf = bufnr('%')

 "haskellならghcのインタプリタ
 if expand('%:e') == "hs"
  let l:bin = "runghc"
 else
  "それ以外なら拡張子そのままをコマンド
  let l:bin = expand('%:e')
 endif
 let l:file = expand('%')
 if bufwinnr('RunScript') > 0
  bw! RunScript
 endif
 execute ':vnew RunScript | 0read ! '. l:bin .' #'

 "ROにする
 " set readonly

 "左側のバッファに戻る
 wincmd h
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
 " return
 hi! link phpVarSelector SpecialChar
 hi! link phpIdentifier Identifier

 hi! link phpDocTags phpDefine
 hi! link phpDocParam phpType

 hi! link phpFunction Function
 hi! link phpFunctions Function
 hi! link phpMethod Function

 hi! link phpMethodsVar Variable

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

function! CopyCurrentFunctionName()
 let @* = NearestMethodOrFunction()
 :call system('clip.exe', @*)
endfunction

function! s:show_documentation()
 if (index(['vim','help'], &filetype) >= 0)
  execute 'h '.expand('<cword>')
 else
  " call CocAction('doHover')
 endif
endfunction

function! CopyToDesktop()
 let l:cmd = "cp ".expand("%")." /c/Users/kimura.AZET/Desktop/".expand("%:t").".bak.".strftime("%Y%m%d")
 echo l:cmd
 call system(l:cmd)
endfunction

function! NearestMethodOrFunction() abort
 return get(b:, 'vista_nearest_method_or_function', '')
endfunction

function! Ecp932()
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
 if OnEntryDir() == 1
  let l:path = "/ent/" . l:path
 endif
 let @+=l:path
 let @"=l:path
 let @*=l:path
 :call system('clip.exe', @+)
endfunction

function! FileNameWithFuncToReg()
 let l:ret = expand("%") . ' 
 \ ' . 'function ' .  get(b:, 'vista_nearest_method_or_function', '')

 let @+=l:ret
 let @"=l:ret
 let @*=l:ret
 :call system('clip.exe', @+)
endfunction

function! FileNameLineToReg()
 let l:ret = expand("%") . " LINE:" . line(".")
 let @+=l:ret
 let @"=l:ret
 let @*=l:ret
 :call system('clip.exe', @+)
endfunction

function! GrepByFileName()
 let l:current_file_name = expand("%:t") "tail modifier
 execute ":Rg " . l:current_file_name
endfunction

function! GrepByCword()
 let l:cword = expand("<cword>")
 execute ":Rg " . l:cword
endfunction

function! EvalVnew(bin_name)
 let l:answer = confirm('Do eval?', "&Yes\n&No", 1)
 if l:answer == 1
  :silent :%y z|vnew|silent 0put=@z|silent execute "%!".a:bin_name
 endif
endfunction

"}}}

"custom command {{{
command! Ecp932 :call Ecp932()
"}}}

"auto command {{{
"phpシンタックス上書き
augroup phpSyntaxOverride
 autocmd!
 autocmd FileType php call PhpSyntaxOverride()
augroup END

"リサイズ時に画面幅をそろえる
augroup Misc
 autocmd!
 autocmd VimResized * exe "normal! \<c-w>="
augroup END

" push quickfix window always to the bottom
" autocmd FileType qf wincmd J
autocmd FileType qf if (getwininfo(win_getid())[0].loclist != 1) | wincmd J | endif

"tab or space
autocmd FileType haskell set tabstop=4|set shiftwidth=4|set expandtab
autocmd FileType html,smarty,css,php,json,javascript set tabstop=2|set shiftwidth=2|set noexpandtab
autocmd FileType sql set tabstop=4|set shiftwidth=2|set noexpandtab|set smarttab
autocmd FileType text set tabstop=2|set shiftwidth=2|set expandtab
autocmd FileType vim set tabstop=1|set shiftwidth=1|set expandtab
autocmd FileType dot set tabstop=2|set shiftwidth=2|set expandtab

"phpは$をキーワードとしてあつかう wで $variable 全体がとれるように
autocmd FileType php :setlocal iskeyword+=$

" WSL ヤンクでクリップボードにコピー
if system("uname -a | grep [m|M]icrosoft") != ''
 augroup myYank
  autocmd!
  autocmd TextYankPost * :call system('clip.exe', @")
  " autocmd TextYankPost * :call system('win32yank.exe -i', @")
 augroup END
endif

augroup autoConvertHtml
 autocmd!
 autocmd BufWritePost suralanote.md | silent! call system("pandochtml ".expand("%")." > /dev/null")
augroup END
"}}}

colorscheme quantum

set foldmethod=marker

"auto open folds
autocmd FileType php normal zR

autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

"diff setting
if &diff                             " only for diff mode/vimdiff
 set diffopt=filler,context:1000000 " filler is default and inserts empty lines for sync
 colo sol
endif

"======================================================================================
"experimental
"======================================================================================
let g:vista_blink = [0, 0]

let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0
let g:strip_whitelines_at_eof=1
let g:show_spaces_that_precede_tabs=1
let g:better_whitespace_ctermcolor='red'
let g:better_whitespace_guicolor='DeepPink'

let g:graphviz_viewer = "/home/yuta/honeyview.sh"
let g:graphviz_output_format = 'png'

let g:jsdoc_lehre_path = "/home/yuta/.yarn/bin/lehre"

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg -j 4 --vimgrep --column --line-number --ignore-case --color=always --ignore-file '.$IGNOREFILE.' -- '.shellescape(<q-args>), 1,)

command! -bang -nargs=* Rgc
  \ call fzf#vim#grep(
  \   'rg -j 4 --vimgrep --column --line-number -S --color=always --ignore-file '.$IGNOREFILE.' -- '.shellescape(<q-args>), 1,)

" CTRL-A CTRL-Q to select all and build quickfix list

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

syntax sync minlines=20000
set redrawtime=10000

let g:Lf_WindowPosition = 'popup'

" --------------------------------------------------------
"coc
""定義もとへ go definition
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gs :vs<CR><Plug>(coc-definition)
"ビジュアル選択をフォーマット
vmap <leader>f <Plug>(coc-format-selected)

function! s:show_documentation()
   if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
   else
      call CocAction('doHover')
   endif
endfunction

hi! link CocErrorVirtualText CocErrorSign
hi! link CocWarningVirtualText CocWarningSign
hi! link CocInfoVirtualText CocInfoSign
hi! link CocHintVirtualText CocHintSign

