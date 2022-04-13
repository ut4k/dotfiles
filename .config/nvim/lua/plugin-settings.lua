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
g.vista_default_executive = "nvim_lsp"
g.vista_ignore_kinds = {'Variable', 'variable'}
g.vista_cursor_delay = 100
g.vista_sidebar_width = 55
g['vista#renderer#enable_icon'] = 1
g.vista_icon_indent = { "╰─▸ ", "├─▸ " }
g.vista_icon_indent = { '└ ', '│ ' }
g.vista_blink = {0, 0}

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

-- -----------------------------------------
-- lspsaga
-- -----------------------------------------
local saga = require 'lspsaga'
saga.init_lsp_saga {
  finder_action_keys = {
    open = '<CR>', vsplit = 's',split = 'i',quit = 'q',scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
  },
  code_action_prompt = {
    enable = false,
    -- sign = true,
    -- sign_priority = 20,
    -- virtual_text = false,
  },
}
vim.api.nvim_set_keymap('n', 'K', ':Lspsaga hover_doc<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'gh', ':Lspsaga preview_definition<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', 'gd', ':Lspsaga lsp_finder<CR>', {noremap = true})

-- init.lua
vim.g.symbols_outline = {
    highlight_hovered_item = true,
    show_guides = false,
    auto_preview = false,
    position = 'right',
    relative_width = true,
    width = 25,
    auto_close = false,
    show_numbers = false,
    show_relative_numbers = false,
    show_symbol_details = false,
    preview_bg_highlight = 'Pmenu',
    keymaps = { -- These keymaps can be a string or a table for multiple keys
        close = {"<Esc>", "q"},
        goto_location = "<Cr>",
        focus_location = "o",
        hover_symbol = "<C-space>",
        toggle_preview = "K",
        rename_symbol = "r",
        code_actions = "a",
    },
    lsp_blacklist = {},
    symbol_blacklist = {
      'Variable',
      'Constant',
      'String',
      'Number',
      'Boolean',
      'Array',
      'Object',
    },
    symbols = {
        File = {icon = "", hl = "TSURI"},
        Module = {icon = "", hl = "TSNamespace"},
        Namespace = {icon = "", hl = "TSNamespace"},
        Package = {icon = "", hl = "TSNamespace"},
        Class = {icon = "𝓒", hl = "TSType"},
        Method = {icon = "ƒ", hl = "TSMethod"},
        Property = {icon = "", hl = "TSMethod"},
        Field = {icon = "", hl = "TSField"},
        Constructor = {icon = "", hl = "TSConstructor"},
        Enum = {icon = "ℰ", hl = "TSType"},
        Interface = {icon = "ﰮ", hl = "TSType"},
        Function = {icon = "", hl = "TSFunction"},
        Variable = {icon = "", hl = "TSConstant"},
        Constant = {icon = "", hl = "TSConstant"},
        String = {icon = "𝓐", hl = "TSString"},
        Number = {icon = "#", hl = "TSNumber"},
        Boolean = {icon = "⊨", hl = "TSBoolean"},
        Array = {icon = "", hl = "TSConstant"},
        Object = {icon = "⦿", hl = "TSType"},
        Key = {icon = "🔐", hl = "TSType"},
        Null = {icon = "NULL", hl = "TSType"},
        EnumMember = {icon = "", hl = "TSField"},
        Struct = {icon = "𝓢", hl = "TSType"},
        Event = {icon = "🗲", hl = "TSType"},
        Operator = {icon = "+", hl = "TSOperator"},
        TypeParameter = {icon = "𝙏", hl = "TSParameter"}
    }
}

-- -----------------------------------------
-- vimspector
-- -----------------------------------------
vim.cmd[[
nnoremap <Leader>dd :call vimspector#Launch()<CR>
nnoremap <Leader>de :call vimspector#Reset()<CR>
nnoremap <Leader>dn :call vimspector#Continue()<CR>

nnoremap <Leader>dt :call vimspector#ToggleBreakpoint()<CR>
nnoremap <Leader>dT :call vimspector#ClearBreakpoints()<CR>
]]
