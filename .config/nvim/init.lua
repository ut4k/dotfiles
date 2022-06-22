require('settings')        -- lua/settings.lua
require('keybindings')     -- lua/keybindings.lua
require('plugins')         -- lua/plugins.lua
require('plugin-settings') -- lua/plugin-settings.lua
require('setup-lualine')   -- lua/setup-lualine.lua

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

vim.cmd[[
set completeopt=menu,menuone,noselect
]]

local snap = require'snap'
local rgopts = {'-H', '--no-heading', '--smart-case', '--ignore-file ' .. HOME .. '.config/ignore/ignore'}
local rgopts = {'--ignore-file ' .. HOME .. '.config/ignore/ignore'}

snap.get'producer.ripgrep.file'.args = {'--ignore-file ' .. HOME .. '.config/ignore/ignore'}
snap.maps {
  {"<c-p>", snap.config.file {producer = "ripgrep.file", preview = false}},
  {"<c-b>", snap.config.file {producer = "vim.oldfile", preview = false}},
  {"ff", snap.config.vimgrep {preview = false}},
}



