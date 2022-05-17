require('settings')        -- lua/settings.lua
require('keybindings')     -- lua/keybindings.lua
require('plugins')         -- lua/plugins.lua
require('lsp')             -- lua/lsp.lua
require('plugin-settings') -- lua/plugin-settings.lua
require('setup-lualine')   -- lua/setup-lualine.lua


vim.cmd[[
autocmd FileType php setlocal omnifunc=lsp#complete
]]
