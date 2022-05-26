HOME = os.getenv('HOME') .. '/'

-- lspのエラーを強調
vim.cmd('autocmd ColorScheme * highlight LspDiagnosticsSignError guibg=red')
vim.cmd('autocmd ColorScheme * highlight LspDiagnosticsSignHint guibg=red')
-- 全角スペース可視化
vim.cmd('autocmd ColorScheme * highlight ZenkakuSpace guibg=magenta')
vim.cmd('autocmd VimEnter,WinEnter * match ZenkakuSpace /　/')
vim.cmd('autocmd FocusGained * silent! checktime')

-- vim.cmd 'colorscheme palenight'
vim.cmd 'colorscheme duskfox'

WORKER = 'kimura'
CURRENT_PROJECT = ''

-- variable
local o = vim.o -- global options
local wo = vim.wo -- buffer-local options
local bo = vim.bo -- window-local options

-- ---------------------------------------
-- basic
-- ---------------------------------------
o.shortmess = vim.o.shortmess .. "c"
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
-- vim.api.nvim_set_option('t_Co', 256) -- 端末がxterm-256colorになっていれば不要
-- o.scriptencoding = 'utf-8'
-- vim.api.nvim_set_option('listchars', 'tab:»,precedes:«,extends:»,eol:↲')
-- o.listchars = { tab = '»', precedes = '«', extends = '»', eol = '↲' }
-- o.listchars = 'tab:»precedes:«extends:»eol:↲'
-- o.listchars = { tab = '»', precedes = '«', extends = '»', eol = '↲' }
-- o.listchars = 'tab:»,precedes:«,extends:»,eol:↲'


o.autoread = true
o.mouse = 'a'
o.ttimeoutlen = 10
o.backspace = 'indent,eol,start'
-- o.clipboard = 'unnamed'
vim.cmd[[
set clipboard&
set clipboard^=unnamedplus
]]
o.autoread = true
o.cursorline = true
o.foldmethod = 'marker'
o.foldlevel = 99
o.hlsearch = true
o.laststatus = 2
o.lazyredraw = true
o.redrawtime = 10000
vim.cmd[[
syntax sync minlines=20000
]]
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

-- html output
vim.g.html_number_lines = 0
vim.g.html_ignore_folding = 1
vim.g.html_font = 'Consolas'

-- diff mode
if wo.diff then -- only for diff mode/vimdiff
 o.diffopt = 'filler,context:1000000' -- filler is default and inserts empty lines for sync
 vim.cmd 'colorscheme sol'
end

-- ---------------------------------------
-- statusline
-- ---------------------------------------
-- local function currentFileFullPath()
-- 	return vim.fn.expand('%:.')
-- end

-- local stl = {
-- 	"%2*",
-- 	currentFileFullPath(),
-- 	"%0*",
-- 	"%r%w",
-- 	"%1*",
-- 	"%m",
-- 	"%r",
-- 	"%h",
-- 	"%0*",
-- 	"%=",
-- 	"%2*",
-- 	"%1*",
-- 	"%0*",
-- 	"[%{&fileencoding}]",
-- 	"[%{&ff=='mac'?'CR':&ff=='unix'?'LF':'CRLF'}]",
-- 	"%1*",
-- 	"%0*",
-- 	"%5.l/%L",
-- }
-- o.statusline = table.concat(stl)

-- ---------------------------------------
-- autocmd
-- ---------------------------------------
function WinPath(path)
 local path = vim.fn.system('wslpath -w ' .. path)
 return vim.fn.strcharpart(path, 0, vim.fn.strlen(path)-1)
end

function WslSync()
 local fp = WinPath(vim.fn.expand("%:p"))
 local dp = WinPath(vim.fn.getcwd())
 local cmd = 'php.exe "D:\\scripts\\wsl_tools\\win\\wsl_sync.php" "'..fp..'" "'..dp..'"'
 vim.fn.system(cmd)
 print("wsl sync done.")
end

-- SuralaLocal
vim.cmd[[
augroup FileWatcher
 autocmd!
 autocmd BufWritePost /mnt/d/workspace/surala/**  silent! call v:lua.WslSync()
 autocmd BufWritePost /mnt/d/workspace/surala_game/**  silent! call v:lua.WslSync()
augroup END
]]

-- phpは$をwordとしてあつかう wで $variable 全体がとれるように
vim.cmd('autocmd FileType php :setlocal iskeyword+=$')

vim.cmd[[
augroup CgiAsPhp
 autocmd!
 autocmd BufEnter,BufNew *.cgi :set ft=php
augroup END
]]

-- tab or space
vim.cmd[[
autocmd FileType haskell    set tabstop=4 | set shiftwidth=4 | set expandtab
autocmd FileType html       set tabstop=2 | set shiftwidth=2 | set noexpandtab
autocmd FileType smarty     set tabstop=2 | set shiftwidth=2 | set noexpandtab
autocmd FileType css        set tabstop=2 | set shiftwidth=2 | set noexpandtab
autocmd FileType php        set tabstop=2 | set shiftwidth=2 | set noexpandtab
autocmd FileType json       set tabstop=2 | set shiftwidth=2 | set noexpandtab
autocmd FileType javascript set tabstop=2 | set shiftwidth=2 | set noexpandtab
autocmd FileType sql        set tabstop=4 | set shiftwidth=2 | set noexpandtab | set smarttab
autocmd FileType text       set tabstop=2 | set shiftwidth=2 | set expandtab
autocmd FileType vim        set tabstop=1 | set shiftwidth=1 | set expandtab
autocmd FileType dot        set tabstop=2 | set shiftwidth=2 | set expandtab
autocmd FileType python     set tabstop=2 | set shiftwidth=2 | set expandtab

augroup autoConvertHtml
 autocmd!
 autocmd BufWritePost suralanote.md | silent! call system("mdtoh ".expand("%")." 7 > /dev/null")
augroup END

augroup readAsSjis
 autocmd!
 autocmd BufReadPost *.ps1 | silent! call Ecp932()
augroup END

autocmd FileType php normal zR
]]

-- リサイズ時に画面幅をそろえる
vim.cmd[[
if bufexists("vimspector.Variables") == 0
	augroup Misc
		autocmd!
		autocmd VimResized * exe "normal! \<c-w>="
	augroup END
endif
]]

-- push quickfix window always to the bottom
vim.cmd[[
	autocmd FileType qf wincmd J
	autocmd FileType qf if (getwininfo(win_getid())[0].loclist != 1) | wincmd J | endif
]]

-- インサートモードを抜けたら半角にもどす
vim.cmd[[
	augroup Zenhan
		autocmd!
		autocmd InsertLeave * call system("zenhan.exe 0")
	augroup END
]]

function WinExplorer()
 local wpath = vim.fn.system("wslpath -w " .. vim.fn.expand('%:p'))
 wpath = string.gsub(wpath, "\n", "") -- remove newline
 -- print(wpath)
 -- TODO: \\wsl$は開けない...
 local cmd = "/mnt/c/Windows/explorer.exe /select,\"" .. wpath .. "\""
 vim.fn.system(cmd)
end

function FileNameToReg()
 local path = vim.fn.expand('%')
 path = path .. ' L:' .. vim.fn.line('.')

 -- if OnEntryDir() == 1
 --  let l:path = "/ent/" . l:path
 -- endif
 vim.fn.system('clip.exe', path)
end

-- "auto command {{{
-- "phpシンタックス上書き
-- augroup phpSyntaxOverride
--  autocmd!
--  " autocmd FileType php call PhpSyntaxOverride()
-- augroup END

-- ファイル拡張子を取得
local function currentFileExtension()
	return vim.fn.expand('%:e')
end

-- "現在のファイルをインタプリタで実行
function RunScript()
	-- 拡張子を取得
	local ext = currentFileExtension()
	-- 拡張子:どのexecutableを使うか
	local binMap = {
		hs = 'runghc',
		go = 'go run',
		py = 'python3',
		sh = 'bash',
		ps1 = 'powershell.exe',
	}

	local bin = binMap[ext]
	if bin == nil then
		bin = ext
	end

	if vim.fn.bufwinnr('RunScript') > 0 then
		vim.cmd('bw! RunScript')
	end

	vim.cmd("execute ':vnew RunScript | 0read ! " .. bin .. " #'")
	vim.cmd('set readonly')
	vim.cmd('wincmd h')
end

vim.cmd[[
augroup Yank
  au!
  autocmd TextYankPost * :call system('clip.exe', @")
augroup END
]]

-- vim.cmd[[
-- autocmd FileType php setlocal omnifunc=lsp#complete
-- ]]
