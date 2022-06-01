local map = vim.api.nvim_set_keymap

local options = { noremap = true } -- no remap option

local PLUGFILE = HOME .. '.config/nvim/lua/plugins.lua'
local LUADIR = HOME .. '.config/nvim/lua/'

-- leader
-- vim.g.mapleader = '<Space>'
vim.g.mapleader = ' '

map('n', ';', ':', options)
map('n', ':', ';', options)
map('v', ';', ':', options)
map('v', ':', ';', options)

-- save
map('n', '<leader>s', ':w<cr>', options)
-- vertical split
map('n', '<leader>v', ':vs<cr>', options)
-- delete without yanking
-- map('n', 'x', '_x', options)
-- replace currently selected text with default register without yanking it
map('v', 'p', '_dP', options)
-- 次のバッファ
map('n', ']b', ':bnext<cr>', options)
-- 前のバッファ
map('n', '[b', ':bprevious<cr>', options)
-- 次のタブ
map('n', ']t', ':tabnext<cr>', options)
-- 前のタブ
map('n', '[t', ':tabprevious<cr>', options)
-- no higlight
map('n', '<f3>', ':noh<cr><cr>', options)
-- vimrcを縦スプリットで開く
map('n', '<leader>ev', ':vs $MYVIMRC<cr><cr>', options)
map('n', '<leader>ep', ':vs '..PLUGFILE..'<cr><cr>', options)
map('n', '<leader>el', ':Vex! '..LUADIR..'<cr><cr>', options)
-- vimrcを再読み込みする
-- map('n', '<f12>', ':source $MYVIMRC<cr>:call PhpSyntaxOverride()<cr><cr>', options)
map('n', '<f12>', ':source $MYVIMRC<cr>', options)
-- tag list pop
map('n', 'tp', ':AerialToggle<cr>', options)
-- gs : gf縦分割バージョン
map('n', 'gs', ':vertical wincmd f<cr>', options)
-- sort u
map('v', '<leader>s', ':sort u<cr>', options)
-- run script
map('n', '<leader>rs', ':call v:lua.RunScript()<cr><cr>', options)
-- align docs
map('v', 'ad', ":!column -t -s \" \" \\| sed 's/^/ /'<cr><cr>", options)
-- generate phpdoc
map('n', '<leader>dc', ':call PhpDocSingle()<cr>', options)
-- "change word by register0 word
map('n', '<leader>x', 'cw<c-r>0', options)
-- disable built-in help
map('n', '<f1>', ':echo<cr>', {})
map('i', '<f1>', '<c-o>:echo<cr>', {})
-- + buffer size vertically
map('n', '<s-h>', ':vert resize +15<cr>', options)
-- - buffer vertically
map('n', '<s-l>', ':vert resize -15<cr>', options)
-- "open in windows explorer
map('n', '<leader>ow', ':call v:lua.WinExplorer()<cr>', options) -- leader -> open in win
-- copy file name to clipboard
map('n', '<leader>fn', ':call v:lua.FileNameToReg()<cr>', options)
-- "ダブルクリックでワードコピー
map('n', '<2-LeftMouse>', ":call system('clip.exe', expand('<cword>'))<cr>:let @/=expand('<cword>')<cr>:set hls<cr>", options)
-- F11でターミナルモードを終了
map('t', '<f11>', '<c-\\><c-n>', options)
-- バッファを閉じる
map('n', '<c-q>', ':quit<cr>', options)
map('n', '<leader>q', ':quit<cr>', options)
-- "https://gist.github.com/iagox86/f96965fb2c6fa5b98077fb25a1bdb1ee
-- " Re-map ctrl-h/j/k/l to move around in normal mode
map('n', '<C-h>', '<C-w>h', options)
map('n', '<C-j>', '<C-w>j', options)
map('n', '<C-k>', '<C-w>k', options)
map('n', '<C-l>', '<C-w>l', options)
-- grep async
map('n', 'ff', ':Clap grep .<cr>', options)
-- map('n', 'ff', ':Clap grep2 .<cr>', options)
-- grep by cursor word
map('n', 'gR', ':Clap grep ++query=<cword><cr>', options)
-- map('n', 'gR', ':Clap grep2 ++query=<cword><cr>', options)

-- local clap_files_exclude = {
-- 	'material',
-- 	'ent'
-- }
-- clap_files_exclude_glob = table.concat(clap_files_exclude, ' ')
-- print(clap_files_exclude_glob)

local clap_files_opt = '++finder=fd --type f -H --ignore-file ~/.config/fd/ignore'
-- find files
map('n', '<c-p>', ':Clap files ' .. clap_files_opt .. ' .<cr>', options)
-- map('n', '<c-p>', ':Clap files .<cr>', options)
-- colorscheme switching
map('n', '<f8>', ':Clap colors<cr>', options)
map('n', '<c-b>', ':Clap recent_files<cr>', options)

-- すべてのfloating windowsを閉じる
function killfwin()
  for _, win in ipairs(vim.api.nvim_list_wins()) do local config = vim.api.nvim_win_get_config(win); if config.relative ~= "" then vim.api.nvim_win_close(win, false); end end
end
vim.api.nvim_set_keymap('n', '<leader>kf', ':lua killfwin()<cr>', {noremap = true})
