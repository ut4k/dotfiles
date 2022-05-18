require('settings')        -- lua/settings.lua
require('keybindings')     -- lua/keybindings.lua
require('plugins')         -- lua/plugins.lua
require('lsp')             -- lua/lsp.lua
require('plugin-settings') -- lua/plugin-settings.lua
require('setup-lualine')   -- lua/setup-lualine.lua

-- experimental
vim.cmd[[
autocmd FileType php setlocal omnifunc=lsp#complete
]]

vim.g.vimspector_code_minwidth = 80
vim.g.vimspector_terminal_maxwidth = 75
vim.g.vimspector_terminal_minwidth = 20

