local g = vim.g -- global variables
-- ----------------------------------------
-- Emmet
-- ----------------------------------------
g.user_emmet_leader_key = '<c-e>'
g.user_emmet_settings = { variables = { lang = 'ja' }}
-- ----------------------------------------
-- EasyAlign
-- ----------------------------------------
g.easy_align_ignore_groups = {}
vim.api.nvim_set_keymap('x', 'ga', '<Plug>(EasyAlign)', {})
-- ----------------------------------------
-- pdv
-- ----------------------------------------
g.pdv_cfg_Type = "string"
g.pdv_cfg_Package = ""
g.pdv_cfg_Version = "$id$"
g.pdv_cfg_Author = ""
g.pdv_cfg_Copyright = ""
g.pdv_cfg_License = ""
g.pdv_cfg_Access = ""
g.pdv_cfg_php4always = 0
g.pdv_cfg_Uses       = 0
g.pdv_cfg_php4always = 0
g.pdv_cfg_php4guess  = 0
-- ----------------------------------------
-- commentary
-- ----------------------------------------
-- vim.cmd('autocmd FileType php setlocal commentstring=// %s')
-- vim.cmd('autocmd FileType smarty setlocal commentstring={* %s *}')
-- vim.cmd('autocmd FileType sql setlocal commentstring=-- %s')
-- ----------------------------------------
-- sorround
-- -----------------------------------------
-- g.surround_{char2nr('q')} = "\\\"\r\\\""
-- -----------------------------------------
-- Vista
-- -----------------------------------------
-- let g:vista_default_executive = "coc"
g.vista_ignore_kinds = {'Variable', 'variable'}
g.vista_cursor_delay = 100
g.vista_sidebar_width = 55
g['vista#renderer#enable_icon'] = 1
g.vista_icon_indent = { "╰─▸ ", "├─▸ " }
g.vista_icon_indent = { '└ ', '│ ' }
g['vista#renderer#ctags'] = 'default'
g.vista_blink = {0, 0}

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

-- -----------------------------------------
-- vim-clap
-- -----------------------------------------
g.clap_theme = 'nord'
g.clap_layout = { relative = 'editor' }
g.clap_open_preview = 'never'
g.clap_enable_icon = 1
g.clap_popup_border = 'double'
-- フォーカスアウトでfloating windowをとじる
vim.cmd[[
function! MyClapOnEnter() abort
  augroup ClapEnsureAllClosed
    autocmd!
    autocmd BufEnter,WinEnter,WinLeave * ++once call clap#floating_win#close() |:stopinsert
  augroup END
endfunction

autocmd User ClapOnEnter call MyClapOnEnter()
]]

-- clap上のみでのマッピング escで即終了させる。(いったんnormalモード戻る挙動を回避)
vim.cmd('autocmd FileType clap_input inoremap <silent> <buffer> <Esc> <Esc>:call clap#handler#exit()<CR>')

-- -----------------------------------------
-- lualine
-- -----------------------------------------
require('lualine').setup()
