require('settings')        -- lua/settings.lua
require('keybindings')     -- lua/keybindings.lua
require('plugins')         -- lua/plugins.lua
require('plugin-settings') -- lua/plugin-settings.lua
require('setup-lualine')   -- lua/setup-lualine.lua
require('lsp')             -- lua/lsp.lua

vim.g.vimspector_enable_mappings = 'HUMAN'
vim.cmd[[
nnoremap <Leader>dd :call vimspector#Launch()<CR>
nnoremap <Leader>de :call vimspector#Reset()<CR>
nnoremap <Leader>dc :call vimspector#Continue()<CR>

nnoremap <Leader>dt :call vimspector#ToggleBreakpoint()<CR>
nnoremap <Leader>dT :call vimspector#ClearBreakpoints()<CR>
]]

