function OnEntryDir()
 return 0
end

-- global variable
local HOME = '/home/yuta/'
local SNIPPETDIR = HOME .. '.vim/config/snippets/'

local IGNOREFILE = HOME .. 'ignore/ignore'
local IGNOREFILE_ENT = HOME .. 'ignore/ignore_ent'

local WORKER = 'kimura'
local CURRENT_PROJECT = ''

-- global options -- vim.api.nvim_set_option()
local o = vim.o
-- buffer-local options -- vim.api.nvim_buf_set_option()
local wo = vim.wo
-- window-local options -- vim.api.nvim_win_set_option()
local bo = vim.bo

local map = vim.api.nvim_set_keymap

-- require 'project.lua'
-- require 'plugins.lua'
require('plugins')
require('plugin_settings')

-- basic
vim.cmd('autocmd ColorScheme * highlight User1 guifg=#ffcb6b guibg=0 gui=bold')
vim.cmd('autocmd ColorScheme * highlight User2 guifg=#c792ea guibg=0')
vim.cmd('autocmd ColorScheme * highlight LspDiagnosticsSignError guibg=red')
vim.cmd('autocmd ColorScheme * highlight LspDiagnosticsSignHint guibg=red')
vim.cmd('autocmd FocusGained * silent! checktime')

-- vim.api.nvim_set_option('t_Co', 256) -- 端末がxterm-256colorになっていれば不要
o.shortmess = vim.o.shortmess .. "c"
-- o.scriptencoding = 'utf-8'
o.encoding = 'utf-8'
o.cmdheight = 1
o.termguicolors = true
o.background = 'dark'
o.ttyfast = true
o.updatetime = 300
o.signcolumn = 'yes'
o.hidden = true -- 保存されていないファイルがあるときでも別のファイルを開くことが出来る
o.gdefault = true -- global substitute by default /g option
o.ignorecase = true
o.smartcase = true
o.list = true
o.ambiwidth = 'single'
-- vim.api.nvim_set_option('listchars', 'tab:»,precedes:«,extends:»,eol:↲')
-- vim.opt.listchars = { tab = '»', precedes = '«', extends = '»', eol = '↲' }
-- o.listchars = { tab = '»', precedes = '«', extends = '»', eol = '↲' }
-- o.listchars = 'tab:»,precedes:«,extends:»,eol:↲'

o.autoread = true
o.mouse = 'a'
o.ttimeoutlen = 10
o.backspace = 'indent,eol,start'
o.clipboard = 'unnamed'
o.autoread = true
o.cursorline = true
o.foldlevel = 99
o.hlsearch = true
o.laststatus = 2
o.lazyredraw = true
o.backup = false
o.ruler = false
o.swapfile = false
o.undofile = false
o.wrap = false
o.number = true
o.regexpengine = 1
o.regexpengine = 0
o.shiftwidth = 2
o.showcmd = true
o.showmatch = true
o.showmode = true
o.splitright = true
o.tabstop = 2
o.title = true
o.tags = 'tags'

-- let $BASH_ENV = expand("$HOME/.bashrc") -- load bash config
-- syntax sync minlines=20000
-- set redrawtime=10000
-- set wildignore+=*\\.git\\*,*\\.hg\\*,*\\.svn\\*
-- set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.jpg,*.png,*.gif,*.jpeg,*.swf
-- set wildignore+=*/.git/*,*/tmp/*,*.swp
-- set cscopequickfix=s+,c+,d+,i+,t+,e+,a+

-- html output
vim.g.html_number_lines = 0
vim.g.html_ignore_folding = 1
vim.g.html_font = 'Consolas'

local function currentFileFullPath()
	return vim.fn.expand('%:.')
end

local stl = {
	"%2*",
	currentFileFullPath(),
	"%0*",
	"%r%w",
	"%1*",
	"%m",
	"%r",
	"%h",
	"%0*",
	"%=",
	"%2*",
	"%1*",
	-- vim.fn.NearestMethodOrFunction(),
	"%0*",
	"[%{&fileencoding}]",
	"[%{&ff=='mac'?'CR':&ff=='unix'?'LF':'CRLF'}]",
	"%1*",
	"%0*",
	"%5.l/%L",
}
o.statusline = table.concat(stl)

-- leader
vim.g.mapleader = ';'
-- no remap option
local mapopts = { noremap = true }
local mapopts2 = { noremap = true, silent = true }
-- save
map('n', '<leader>s', ':w<cr>', mapopts)
-- delete without yanking
map('n', 'x', '_x', mapopts)
-- replace currently selected text with default register without yanking it
map('v', 'p', '_dP', mapopts)
-- バッファ履歴使うので使わない...
-- 次のバッファ
map('n', ']b', ':bnext<cr>', mapopts)
-- 前のバッファ
map('n', '[b', ':bprevious<cr>', mapopts)
-- 次のタブ
map('n', ']t', ':tabnext<cr>', mapopts)
-- 前のタブ
map('n', '[t', ':tabprevious<cr>', mapopts)
-- no higlight
map('n', '<f3>', ':noh<cr><cr>', mapopts)
-- vimrcを縦スプリットで開く
map('n', '<leader>ev', ':vs $MYVIMRC<cr><cr>', mapopts)
-- vimrcを再読み込みする
map('n', '<f12>', ':source $MYVIMRC<cr>:call PhpSyntaxOverride()<cr><cr>', mapopts2)
-- tag list pop
map('n', 'tp', ':Vista!!<cr>', mapopts)
-- gs : gf縦分割バージョン
map('n', 'gs', ':vertical wincmd f<cr>', mapopts)
-- sort u
map('v', '<leader>s', ':sort u<cr>', mapopts)
-- run script
map('n', '<leader>rs', ':call RunScript()<cr><cr>', mapopts)
-- align docs
map('v', 'ad', ":!column -t -s \" \" \\| sed 's/^/ /'<cr><cr>", mapopts)
-- generate phpdoc
map('n', '<leader>dc', ':call PhpDocSingle()<cr>', mapopts)
-- "change word by register0 word
map('n', '<leader>x', 'cw<c-r>0', mapopts)
-- go to abs path file
map('n', '<leader>gaf', ':<C-u>call GotoFileFromDocRoot()<cr>', mapopts)
-- disable built-in help
map('n', '<f1>', ':echo<cr>', {})
map('i', '<f1>', '<c-o>:echo<cr>', {})
-- + buffer size vertically
map('n', '<s-h>', ':vert resize +15<cr>', mapopts)
-- - buffer vertically
map('n', '<s-l>', ':vert resize -15<cr>', mapopts)
-- next error (quickfix)
map('n', '<f5>', ':cnext<cr>', mapopts)
-- previous error (quickfix)
map('n', '<f6>', ':cprevious<cr>', mapopts)
-- "open in windows explorer
map('n', '<leader>ow', ':call WinExplorer()<cr>', mapopts) -- leader -> open in win
-- " Use K to show documentation in preview window
map('n', 'K', ':call <SID>show_documentation()<cr>', mapopts)
-- copy file name to clipboard
map('n', '<leader>fn', ':call FileNameToReg()<cr>', mapopts)
-- copy file name with line number to clipboard
map('n', '<leader>fn', ':call FileNameLineToReg()<cr>', mapopts)
-- "ダブルクリックでワードコピー
map('n', '<2-LeftMouse>', ":call system('clip.exe', expand('<cword>'))<cr>:let @/=expand('<cword>')<CR>:set hls<cr>", mapopts2)
-- next colorscheme
map('n', '<f8>', ':call NextColorScheme()<cr>:call PhpSyntaxOverride()<cr>', mapopts)
-- F11でターミナルモードを終了
map('t', '<f11>', '<c-\\><c-n>', mapopts)
-- strip trailing white spaces
map('n', '<leader>ws', ':StripWhitespace<cr><cr>', mapopts)

-- "plugin settings{{{
-- "----------------------------------------
-- " Emmet
-- "----------------------------------------
-- let g:user_emmet_leader_key='<c-e>'
-- let g:user_emmet_settings = {
--    \    'variables': {
--    \      'lang': "ja"
--    \    },
--    \   'indentation': '  '
--    \ }
-- "----------------------------------------
-- " EasyAlign
-- "----------------------------------------
-- " Start interactive EasyAlign in visual mode (e.g. vipga)
-- xmap ga <Plug>(EasyAlign)
-- " ignore nothing
-- let g:easy_align_ignore_groups = []
-- "----------------------------------------
-- " pdv
-- "----------------------------------------
-- let g:pdv_cfg_Type = "string"
-- let g:pdv_cfg_Package = ""
-- let g:pdv_cfg_Version = "$id$"
-- let g:pdv_cfg_Author = ""
-- let g:pdv_cfg_Copyright = ""
-- let g:pdv_cfg_License = ""
-- let g:pdv_cfg_Access = ""
-- let g:pdv_cfg_php4always = 0
-- let g:pdv_cfg_Uses       = 0
-- let g:pdv_cfg_php4always = 0
-- let g:pdv_cfg_php4guess  = 0
-- "----------------------------------------
-- " php.vim
-- "----------------------------------------
-- " let g:php_html_load = 0
-- " let g:php_html_in_heredoc = 0
-- " let g:php_html_in_nowdoc = 0
-- " let g:php_var_selector_is_identifier= 1
-- " let g:php_baselib = 1
-- " let g:php_parent_error_close = 0
-- " let g:php_parent_error_open = 0
-- " let g:php_sql_query = 0
-- " let g:php_folding = 0
-- " let g:php_sql_heredoc = 0
-- " let g:php_sql_nowdoc = 0
-- "----------------------------------------
-- " commentary
-- "----------------------------------------
-- autocmd FileType php setlocal commentstring=//\ %s
-- autocmd FileType smarty setlocal commentstring={*\ %s\ *}
-- autocmd FileType sql setlocal commentstring=--\ %s
-- "-----------------------------------------
-- " sorround
-- "-----------------------------------------
-- let g:surround_{char2nr('q')} = "\\\"\r\\\""
-- "-----------------------------------------
-- " UltiSnips
-- "-----------------------------------------
-- " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
-- let g:UltiSnipsExpandTrigger="<tab>"
-- let g:UltiSnipsJumpForwardTrigger="<c-b>"
-- let g:UltiSnipsJumpBackwardTrigger="<c-z>"
-- " If you want :UltiSnipsEdit to split your window.
-- let g:UltiSnipsEditSplit="vertical"
-- let g:UltiSnipsSnippetDirectories=[$HOME . '/.vim/config/snippets']
-- "-----------------------------------------
-- " Vista
-- "-----------------------------------------
-- " let g:vista_default_executive = "ctags"
-- let g:vista_default_executive = "coc"
-- let g:vista_ignore_kinds = ['Variable', 'variable']
-- let g:vista_cursor_delay = 100
-- let g:vista_sidebar_width = 55
-- let g:vista#renderer#enable_icon = 1
-- let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
-- let g:vista_icon_indent = ['└ ', '│ ']
-- let g:vista#renderer#ctags = 'default'

-- "fzf symbol
-- " nnoremap <C-s> :Vista finder<CR>
-- " -----------------------------------------
-- " vim-colorscheme-switcher
-- " -----------------------------------------
-- let g:colorscheme_switcher_exclude_builtins=1
-- " -----------------------------------------
-- " phpcomplete
-- " -----------------------------------------
-- let g:phpcomplete_enhance_jump_to_definition = 1
-- " let g:phpcomplete_mappings = {
-- "    \ 'jump_to_def': '<C-]>',
-- "    \ 'jump_to_def_split': '<C-W><C-]>',
-- "    \ 'jump_to_def_vsplit': '<C-W><C-\>',
-- "    \ 'jump_to_def_tabnew': '<C-W><C-[>',
-- "    \}
-- " -----------------------------------------
-- "  fzf
-- " -----------------------------------------
-- " let g:fzf_preview_window = 'right:40%'
-- " let g:fzf_preview_window = []
-- " let g:fzf_prefer_tmux = 0
-- " let g:fzf_layout = { 'down' : '~14%' }
-- " let g:fzf_layout = {'up':'~70%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }

-- " https://github.com/junegunn/fzf.vim/issues/664#issuecomment-476438294
-- let g:fzf_layout = { 'window': 'call FloatingFZF()' }

-- function! FloatingFZF()
--   let buf = nvim_create_buf(v:false, v:true)
--   call setbufvar(buf, '&signcolumn', 'no')

--   let height = &lines - 3
--   let width = float2nr(&columns - (&columns * 2 / 10))
--   let col = float2nr((&columns - width) / 2)

--   let opts = {
--         \ 'relative': 'editor',
--         \ 'row': 1,
--         \ 'col': col,
--         \ 'width': width,
--         \ 'height': height
--         \ }

--   call nvim_open_win(buf, v:true, opts)
-- endfunction

-- " let g:fzf_colors =
-- " \ { 'fg':      ['fg', 'Normal'],
-- "   \ 'bg':      ['bg', 'Normal'],
-- "   \ 'hl':      ['fg', 'Comment'],
-- "   \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
-- "   \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
-- "   \ 'hl+':     ['fg', 'Statement'],
-- "   \ 'info':    ['fg', 'PreProc'],
-- "   \ 'border':  ['fg', 'Ignore'],
-- "   \ 'prompt':  ['fg', 'Conditional'],
-- "   \ 'pointer': ['fg', 'Exception'],
-- "   \ 'marker':  ['fg', 'Keyword'],
-- "   \ 'spinner': ['fg', 'Label'],
-- "   \ 'header':  ['fg', 'Comment'] }


-- " -----------------------------------------
-- "  gen_tags
-- " -----------------------------------------
-- " let g:gen_tags#ctags_auto_gen = 0
-- " let g:gen_tags#statusline = 0
-- " let g:gen_tags#gtags_default_map = 0
-- " let g:loaded_gentags#ctags = 1
-- " -----------------------------------------
-- "  vim-javascript
-- " -----------------------------------------
-- let g:javascript_plugin_jsdoc = 1
-- "}}}

-- "functions{{{
-- "全角スペースをハイライト表示
-- function! ZenkakuSpace()
--  highlight ZenkakuSpace guibg=purple
-- endfunction

-- if has('syntax')
--  augroup ZenkakuSpace
--   autocmd!
--   autocmd ColorScheme       * call ZenkakuSpace()
--   autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
--  augroup END
--  call ZenkakuSpace()
-- endif

-- function! ToLF()
-- :e ++ff=unix
-- endfunction

-- "現在のファイルをインタプリタで実行
-- function! RunScript()
--  "現在のバッファ
--  let l:curbuf = bufnr('%')

--  "haskell
--  if expand('%:e') == "hs"
--   let l:bin = "runghc"
--  "go
--  elseif expand('%:e') == "go"
--   let l:bin = "go run"
--  "python
--  elseif expand('%:e') == "py"
--   let l:bin = "python3"
--  "bash
--  elseif expand('%:e') == "sh"
--   let l:bin = "bash"
--  "powershell
--  elseif expand('%:e') == "ps1"
--   let l:bin = "powershell.exe"
--  else
--   "それ以外なら拡張子そのままをコマンド
--   let l:bin = expand('%:e')
--  endif

--  let l:file = expand('%')
--  if bufwinnr('RunScript') > 0
--   bw! RunScript
--  endif

--  execute ':vnew RunScript | 0read ! '. l:bin .' #'

--  "ROにする
--  " set readonly

--  "左側のバッファに戻る
--  wincmd h
-- endfunction

-- "現在のファイルをインタプリタで実行
-- function! RunInTmux()
--  "haskellならghcのインタプリタ
--  if expand('%:e') == "hs"
--   let l:bin = "runghc"
--  else
--   "それ以外なら拡張子そのままをコマンド
--   let l:bin = expand('%:e')
--  endif
--  let l:file = expand('%')
--  execute '!tmux send-keys -t 1 "'.l:bin.' '.l:file.'" Enter'
-- endfunction


-- function! PhpSyntaxOverride()
--  " return
--  hi! link phpVarSelector SpecialChar
--  hi! link phpIdentifier Identifier

--  hi! link phpDocTags phpDefine
--  hi! link phpDocParam phpType

--  hi! link phpFunction Function
--  hi! link phpFunctions Function
--  hi! link phpMethod Function

--  hi! link phpMethodsVar Variable

--  hi! link phpRegion phpClasses
-- endfunction

-- "docrootからのパスで開く
-- function! GotoFileFromDocRoot()
--  let root_dir = getcwd() . "/"
--  let filename = getline('.')
--  let filepath = root_dir . filename
--  if filereadable(filepath)
--   execute 'edit ' . filepath
--  else
--   echohl ErrorMsg
--   echo 'ファイルが見つかりませんでした!  ---> ' . filename
--   echohl None
--  endif
-- endfunction

-- function! GotoEntFile()
--  let filename = getline('.')
--  let filepath = "/d/workspace/surala" . filename
--  if filereadable(filepath)
--   execute 'edit ' . filepath
--  else
--   echohl ErrorMsg
--   echo 'ファイルが見つかりませんでした!  ---> ' . filename
--   echohl None
--  endif
-- endfunction

-- function! VarDumpPhpVariable()
--  let @* = "var_dump(" . expand('<cword>') . "); //########## TODO kimura ".strftime("%Y/%m/%d")." ##########"
-- endfunction

-- function! PrePhpVariable()
--  let @* = "pre(" . expand('<cword>') . "); //########## TODO kimura ".strftime("%Y/%m/%d")." ##########"
-- endfunction

-- function! ClogVar()
--  let @* = "console.log(\"" . expand('<cword>') . ":\", " . expand('<cword>') . "); //########## TODO kimura ".strftime("%Y/%m/%d")." ##########"
-- endfunction

-- function! QFixToggle()
--  let _ = winnr('$')
--  cclose
--  if _ == winnr('$')
--   cwindow
--  endif
-- endfunction

-- function! RunC()
--  if (&filetype == "c")
--   execute '!gcc '.expand('%').' && ./a.out'
--  else
--   echohl WarningMsg | echo 'cannot run. not a c file.'
--  endif
-- endfunction

-- function! CopyIntoOrgDir(newName)
--  let l:cmd = 'cp ' . expand('%') . ' ' . expand('%:h') . '/'. a:newName
--  echo l:cmd
--  call system(l:cmd)
--  execute 'edit ' . expand('%:h') . '/'. a:newName
-- endfunction

-- function! LinterStatus() abort
--  let l:counts = ale#statusline#Count(bufnr(''))

--  let l:all_errors = l:counts.error + l:counts.style_error
--  let l:all_non_errors = l:counts.total - l:all_errors

--  return l:counts.total == 0 ? 'OK' : printf(
--     \   '%dW %dE',
--     \   all_non_errors,
--     \   all_errors
--     \)
-- endfunction

-- function! CopyCurrentFunctionName()
--  let @* = NearestMethodOrFunction()
--  :call system('clip.exe', @*)
-- endfunction

-- function! s:show_documentation()
--  if (index(['vim','help'], &filetype) >= 0)
--   execute 'h '.expand('<cword>')
--  else
--   " call CocAction('doHover')
--  endif
-- endfunction

-- function! CopyToDesktop()
--  let l:cmd = "cp ".expand("%")." /c/Users/kimura.AZET/Desktop/".expand("%:t").".bak.".strftime("%Y%m%d")
--  echo l:cmd
--  call system(l:cmd)
-- endfunction

-- function! NearestMethodOrFunction() abort
--  return get(b:, 'vista_nearest_method_or_function', '')
-- endfunction

-- function! Ecp932()
--  :e ++enc=cp932
-- endfunction

-- function! WinExplorer()
--  let l:wpath = trim(system("wslpath -w " .expand("%:p")))
--  let l:cmd = "/mnt/c/Windows/explorer.exe /select,\"" . l:wpath . "\""
--  echo "opening ".l:wpath." ..."
--  call system(l:cmd)
-- endfunction

-- function! FileNameToReg()
--  let l:path = expand("%")
--  if OnEntryDir() == 1
--   let l:path = "/ent/" . l:path
--  endif
--  let @+=l:path
--  let @"=l:path
--  let @*=l:path
--  :call system('clip.exe', @+)
-- endfunction

-- function! FileNameWithFuncToReg()
--  let l:ret = expand("%") . ' 
--  \ ' . 'function ' .  get(b:, 'vista_nearest_method_or_function', '')

--  let @+=l:ret
--  let @"=l:ret
--  let @*=l:ret
--  :call system('clip.exe', @+)
-- endfunction

-- function! FileNameLineToReg()
--  let l:ret = expand("%") . " line:" . line(".")
--  let @+=l:ret
--  let @"=l:ret
--  let @*=l:ret
--  :call system('clip.exe', @+)
-- endfunction

-- function! GrepByFileName()
--  let l:current_file_name = expand("%:t") "tail modifier
--  execute ":Rg " . l:current_file_name
-- endfunction

-- function! GrepByCword()
--  let l:cword = expand("<cword>")
--  execute ":Rg " . l:cword
-- endfunction

-- function! EvalVnew(bin_name)
--  let l:answer = confirm('Do eval?', "&Yes\n&No", 1)
--  if l:answer == 1
--   :silent :%y z|vnew|silent 0put=@z|silent execute "%!".a:bin_name
--  endif
-- endfunction

-- "}}}

-- "custom command {{{
-- command! Ecp932 :call Ecp932()
-- "}}}

-- "auto command {{{
-- "phpシンタックス上書き
-- augroup phpSyntaxOverride
--  autocmd!
--  " autocmd FileType php call PhpSyntaxOverride()
-- augroup END

-- "リサイズ時に画面幅をそろえる
-- augroup Misc
--  autocmd!
--  autocmd VimResized * exe "normal! \<c-w>="
-- augroup END

-- " push quickfix window always to the bottom
-- " autocmd FileType qf wincmd J
-- " autocmd FileType qf if (getwininfo(win_getid())[0].loclist != 1) | wincmd J | endif

-- "tab or space
-- autocmd FileType haskell set tabstop=4|set shiftwidth=4|set expandtab
-- autocmd FileType html,smarty,css,php,json,javascript set tabstop=2|set shiftwidth=2|set noexpandtab
-- autocmd FileType sql set tabstop=4|set shiftwidth=2|set noexpandtab|set smarttab
-- autocmd FileType text set tabstop=2|set shiftwidth=2|set expandtab
-- autocmd FileType vim set tabstop=1|set shiftwidth=1|set expandtab
-- autocmd FileType dot set tabstop=2|set shiftwidth=2|set expandtab
-- autocmd FileType python set tabstop=2|set shiftwidth=2|set expandtab

-- "phpは$をキーワードとしてあつかう wで $variable 全体がとれるように
-- autocmd FileType php :setlocal iskeyword+=$

-- " WSL ヤンクでクリップボードにコピー
-- if system("uname -a | grep [m|M]icrosoft") != ''
--  augroup myYank
--   autocmd!
--   autocmd TextYankPost * :call system('clip.exe', @")
--   " autocmd TextYankPost * :call system('win32yank.exe -i', @")
--  augroup END
-- endif

-- augroup autoConvertHtml
--  autocmd!
--  autocmd BufWritePost suralanote.md | silent! call system("mdtoh ".expand("%")." 7 > /dev/null")
-- augroup END

-- augroup readAsSjis
--  autocmd!
--  autocmd BufReadPost *.ps1 | silent! call Ecp932()
-- augroup END
-- "}}}

-- " colorscheme quantum
-- " colorscheme neon
-- colorscheme nightfox

-- set foldmethod=marker

-- "auto open folds
-- autocmd FileType php normal zR

-- autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

-- "diff setting
-- if &diff                             " only for diff mode/vimdiff
--  set diffopt=filler,context:1000000 " filler is default and inserts empty lines for sync
--  colo sol
-- endif

-- "======================================================================================
-- "experimental
-- "======================================================================================
-- let g:vista_blink = [0, 0]

-- let g:better_whitespace_enabled=1
-- let g:strip_whitespace_on_save=1
-- let g:strip_whitespace_confirm=0
-- let g:strip_whitelines_at_eof=1
-- let g:show_spaces_that_precede_tabs=1
-- let g:better_whitespace_ctermcolor='red'
-- let g:better_whitespace_guicolor='DeepPink'

-- let g:graphviz_viewer = "/home/yuta/honeyview.sh"
-- let g:graphviz_output_format = 'png'

-- let g:jsdoc_lehre_path = "/home/yuta/.yarn/bin/lehre"

-- "ripgrep php
-- command! -bang -nargs=* RgPhp
--   \ call fzf#vim#grep(
--   \   'rg -g *.php --vimgrep --column --line-number --color=always --ignore-file '.$IGNOREFILE.' '.shellescape(<q-args>), 1, 0)

-- "ripgrep js
-- command! -bang -nargs=* RgJs
--   \ call fzf#vim#grep(
--   \   'rg -g *.js --vimgrep --column --line-number --color=always --ignore-file '.$IGNOREFILE.' '.shellescape(<q-args>), 1, 0)

-- "ripgrep all
-- command! -bang -nargs=* Rg
--   \ call fzf#vim#grep(
--   \   'rg --vimgrep --column --line-number --color=always --ignore-file '.$IGNOREFILE.' '.shellescape(<q-args>), 1, 0)

-- " ripgrep case sensitive (-S)
-- command! -bang -nargs=* Rgc
--   \ call fzf#vim#grep(
--   \   'rg --vimgrep --column --line-number -S --color=always --ignore-file '.$IGNOREFILE.' '.shellescape(<q-args>), 1, 0)

-- " ripgrep with filetype
-- command! -bang -nargs=* Rgf
--   \ call RgSpecificFileType(<q-args>)

-- function! RgSpecificFileType(query)
--   let l:ft = input('File Type?: ')
--   call fzf#vim#grep('rg -g *.'.l:ft.' --vimgrep --column --line-number --color=always --ignore-file '.$IGNOREFILE.' '.shellescape(a:query), 1, 0)
-- endfunction

-- " CTRL-A CTRL-Q to select all and build quickfix list

-- function! s:build_quickfix_list(lines)
--   call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
--   copen
--   cc
-- endfunction

-- " let g:fzf_action = {
-- "   \ 'ctrl-q': function('s:build_quickfix_list'),
-- "   \ 'ctrl-t': 'tab split',
-- "   \ 'ctrl-x': 'split',
-- "   \ 'ctrl-v': 'vsplit' }

-- let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

-- syntax sync minlines=20000
-- set redrawtime=10000

-- let g:Lf_WindowPosition = 'popup'

-- " --------------------------------------------------------
-- "coc
-- ""定義もとへ go definition
-- nmap <silent> gd <Plug>(coc-definition)
-- nmap <silent> gs :vs<CR><Plug>(coc-definition)
-- "ビジュアル選択をフォーマット
-- vmap <leader>f <Plug>(coc-format-selected)

-- function! s:show_documentation()
--    if (index(['vim','help'], &filetype) >= 0)
--       execute 'h '.expand('<cword>')
--    else
--       call CocAction('doHover')
--    endif
-- endfunction

-- hi! link CocErrorVirtualText CocErrorSign
-- hi! link CocWarningVirtualText CocWarningSign
-- hi! link CocInfoVirtualText CocInfoSign
-- hi! link CocHintVirtualText CocHintSign

-- let g:previm_open_cmd = '/mnt/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe'
-- let g:previm_wsl_mode = 1

-- " let g:previm_open_cmd="/mnt/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe"
-- " let g:previm_wsl_mode = 1
-- "
-- " nnoremap <silent> <Leader>g :<C-u>silent call <SID>find_rip_grep()<CR>

-- " function! s:find_rip_grep() abort
-- "     call fzf#vim#grep(
-- "                 \   'rg --hidden --column --line-number --no-heading --ignore-file '.$IGNOREFILE.' --smart-case .+',
-- "                 \   1,
-- "                 \   0,
-- "                 \ )
-- " endfunction

-- "https://gist.github.com/iagox86/f96965fb2c6fa5b98077fb25a1bdb1ee
-- " Re-map ctrl-h/j/k/l to move around in normal mode
-- nnoremap <C-h> <C-w>h
-- nnoremap <C-j> <C-w>j
-- nnoremap <C-k> <C-w>k
-- nnoremap <C-l> <C-w>l

-- " 有効にしちゃうとFZFの検索結果を移動できなくなる
-- " Re-map ctrl-h/j/k/l to move around in terminal mode
-- " tnoremap <C-h> <C-\><C-n><C-w>h
-- " tnoremap <C-j> <C-\><C-n><C-w>j
-- " tnoremap <C-k> <C-\><C-n><C-w>k
-- " tnoremap <C-l> <C-\><C-n><C-w>l

-- " Make ctrl-w escape insert mode
-- tnoremap <C-w> <C-\><C-n><C-w>
-- inoremap <C-w> <esc><C-w>

-- " Let <enter> enter insert mode (helpful for terminals)
-- " quickfix, floating windowの中でenterを使う機能が使えなくなるので廃止！
-- " tnoremap <return> i

-- " SuralaLocal
-- augroup FileWatcher
--  autocmd!
--  autocmd BufWritePost /mnt/d/workspace/surala/**  silent! call WslSync()
-- augroup END

-- function! WslSync()
--  let l:fp = WinPath(expand("%:p"))
--  let l:dp = WinPath(getcwd())
--  let l:cmd = "php.exe \"D:\\scripts\\wsl_tools\\win\\wsl_sync.php\" \"".l:fp."\" \"".l:dp."\""
--  " redir @a
--  " echo l:cmd
--  " redir END
--  call system(l:cmd)
-- endfunction

-- function! WinPath(path)
--  let l:path = system("wslpath -w " . a:path)
--  return strcharpart(l:path, 0, strlen(l:path)-1)
-- endfunction

-- function! WorkspaceRoot()
--  return expand("%:p:h")
-- endfunction

-- let g:vdebug_options= {
-- \    "port" : 9000,
-- \    "server" : '',
-- \    "timeout" : 10,
-- \    "on_close" : 'detach',
-- \    "break_on_open" : 1,
-- \    "ide_key" : 'VSCODE',
-- \    "path_maps" : {},
-- \    "debug_window_level" : 0,
-- \    "debug_file_level" : 2,
-- \    "debug_file" : "/home/yuta/vdebug.log",
-- \    "watch_window_style" : 'expanded',
-- \    "marker_default" : '⬦',
-- \    "marker_closed_tree" : '▸',
-- \    "marker_open_tree" : '▾'
-- \}

-- let g:vdebug_options['path_maps'] = {"/data/home": getcwd()}

-- let g:vdebug_keymap = {
--    \    "run" : "<leader>v",
--    \    "run_to_cursor" : "<F9>",
--    \    "step_over" : "<F2>",
--    \    "step_into" : "<F3>",
--    \    "step_out" : "<F4>",
--    \    "close" : "<F6>",
--    \    "detach" : "<F7>",
--    \    "set_breakpoint" : "<F10>",
--    \    "get_context" : "<F11>",
--    \    "eval_under_cursor" : "<F12>",
--    \    "eval_visual" : "<Leader>e",
--    \}


-- function! OutputSplitWindow(...)
--   " this function output the result of the Ex command into a split scratch buffer
--   let cmd = join(a:000, ' ')
--   let temp_reg = @"
--   redir @"
--   silent! execute cmd
--   redir END
--   let output = copy(@")
--   let @" = temp_reg
--   if empty(output)
--     echoerr "no output"
--   else
--     new
--     setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted
--     put! =output
--   endif
-- endfunction
-- command! -nargs=+ -complete=command Output call OutputSplitWindow(<f-args>)


-- lua << EOF
-- require'fzf-lua'.setup {
--   winopts = {
--     height = 0.50,
--     width = 0.90,
--     preview = {
--       horizontal = 'right:30%',
--     }
--   },
--   keymap = {
--     fzf = {
--       ["ctrl-q"] = "select-all+accept",
--     }
--   }
-- }
-- EOF

-- lua << EOF
-- local dap = require"dap"

-- dap.configurations.lua = { 
--   { 
--     type = 'nlua', 
--     request = 'attach',
--     name = "Attach to running Neovim instance",
--     host = function()
--       local value = vim.fn.input('Host [127.0.0.1]: ')
--       if value ~= "" then
--         return value
--       end
--       return '127.0.0.1'
--     end,
--     port = function()
--       local val = tonumber(vim.fn.input('Port: '))
--       assert(val, "Please provide a port number")
--       return val
--     end,
--   }
-- }

-- dap.adapters.nlua = function(callback, config)
--   callback({ type = 'server', host = config.host, port = config.port })
-- end
-- EOF
