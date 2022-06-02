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
vim.cmd('autocmd FileType php setlocal commentstring=//%s')
-- vim.cmd('autocmd FileType smarty setlocal commentstring={* %s *}')
-- vim.cmd('autocmd FileType sql setlocal commentstring=-- %s')
-- ----------------------------------------
-- sorround
-- -----------------------------------------
-- g.surround_{char2nr('q')} = "\\\"\r\\\""
-- -----------------------------------------
-- Vista
-- -----------------------------------------
-- g.vista_default_executive = "nvim_lsp"
-- g.vista_ignore_kinds = {'Variable', 'variable'}
-- g.vista_cursor_delay = 100
-- g.vista_sidebar_width = 55
-- g['vista#renderer#enable_icon'] = 1
-- g.vista_icon_indent = { "╰─▸ ", "├─▸ " }
-- g.vista_icon_indent = { '└ ', '│ ' }
-- g.vista_blink = {0, 0}

-- -----------------------------------------
-- vim-clap
-- -----------------------------------------
g.clap_theme = 'nord'
g.clap_layout = { relative = 'editor' }
g.clap_open_preview = 'never'
g.clap_enable_icon = 0
g.clap_popup_border = 'double'
g.clap_provider_grep_opts = '-H --no-heading --vimgrep --smart-case --ignore-file ' .. HOME .. '.config/ignore/ignore'
g.clap_provider_rg_opts = '-H --no-heading --vimgrep --smart-case --ignore-file ' .. HOME .. '.config/ignore/ignore'
g.clap_provider_maple_opts = '-H --no-heading --vimgrep --smart-case --ignore-file ' .. HOME .. '.config/ignore/ignore'
-- Default: '-H --no-heading --vimgrep --smart-case'
-- フォーカスアウトでfloating windowをとじる

-- vim.cmd[[
-- function! MyClapOnEnter() abort
--   augroup ClapEnsureAllClosed
--     autocmd!
--     autocmd BufEnter,WinEnter,WinLeave * ++once call clap#floating_win#close() |:stopinsert
--   augroup END
-- endfunction

-- autocmd User ClapOnEnter call MyClapOnEnter()
-- ]]

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

-- -----------------------------------------
-- aerial.nvim
-- -----------------------------------------
require('aerial').setup({})

-- -----------------------------------------
-- vimspector
-- -----------------------------------------
vim.cmd[[
nnoremap <f5> :call vimspector#Launch()<CR>
nnoremap <f6> :call vimspector#Reset()<CR>
nnoremap <Leader>dn :call vimspector#Continue()<CR>
nnoremap <Leader>dt :call vimspector#ToggleBreakpoint()<CR>
nnoremap <Leader>dT :call vimspector#ClearBreakpoints()<CR>
]]

function Foo()
  local conf = {
    Php = {
      adapter = "vscode-php-debug",
      filetypes = { "php" },
      default = true,
      configuration = {
        request = "launch",
        protocol = "auto",
        stopOnEntry = true,
        -- cwd = "${workspaceRoot}"
      }
    }
  }
  -- vim.fn['vimspector#LaunchWithConfigurations'](conf)
  vim.fn['vimspector#LaunchWithConfigurations']({})
end
vim.api.nvim_set_keymap('n', '<f7>', ':call v:lua.Foo()<cr>', {noremap = true})

-- -----------------------------------------
-- lspconfig
-- -----------------------------------------
require('lspconfig').intelephense.setup({
    on_attach = function(client, bufnr)
      -- Enable (omnifunc) completion triggered by <c-x><c-o>
      vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
      vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", {noremap = true})
      -- Here we should add additional keymaps and configuration options.
    end,
    flags = {
      debounce_text_changes = 150,
    }
})
--
require("nvim-treesitter.configs").setup({
 ensure_installed = { "php" },
 sync_installed = true,
 highlight = {
  enable = true, -- This is a MUST
  additional_vim_regex_highlighting = { "php" },
 },
 indent = {
  enable = false, -- Really breaks stuff if true
 },
 incremental_selection = {
  enable = true,
  keymaps = {
   init_selection = "gnn",
   node_incremental = "grn",
   scope_incremental = "grc",
   node_decremental = "grm",
  },
 },
})


require'treesitter-context'.setup{
    enable = false, -- Enable this plugin (Can be enabled/disabled later via commands)
    -- max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    max_lines = 1, -- How many lines the window should span. Values <= 0 mean no limit.
    patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
        default = {
            'class',
            'function',
            'method',
            'foreach',
            -- 'for', -- These won't appear in the context
            -- 'while',
            -- 'if',
            -- 'switch',
            -- 'case',
        },
        -- Example for a specific filetype.
        -- If a pattern is missing, *open a PR* so everyone can benefit.
        --   rust = {
        --       'impl_item',
        --   },
    },
    exact_patterns = {
        -- Example for a specific filetype with Lua patterns
        -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
        -- exactly match "impl_item" only)
        -- rust = true,
    },

    -- [!] The options below are exposed but shouldn't require your attention,
    --     you can safely ignore them.

    zindex = 20, -- The Z-index of the context window
}
