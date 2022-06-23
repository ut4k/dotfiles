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


-- local M = {}

-- local function configure()
--   local dap_install = require "dap-install"
--   dap_install.setup {
--     installation_path = vim.fn.stdpath "data" .. "/dapinstall/",
--   }

--   local dap_breakpoint = {
--     error = {
--       text = "🟥",
--       texthl = "LspDiagnosticsSignError",
--       linehl = "",
--       numhl = "",
--     },
--     rejected = {
--       text = "",
--       texthl = "LspDiagnosticsSignHint",
--       linehl = "",
--       numhl = "",
--     },
--     stopped = {
--       text = "⭐️",
--       texthl = "LspDiagnosticsSignInformation",
--       linehl = "DiagnosticUnderlineInfo",
--       numhl = "LspDiagnosticsSignInformation",
--     },
--   }

--   vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
--   vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
--   vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)

--   local dap = require'dap'
--   dap.adapters.php = {
--     type = 'executable',
--     command = 'nodejs',
--     args = {"/opt/vscode-php-debug/out/phpDebug.js"},
--   }

--   dap.configurations.php = {
--     {
--       type = 'php',
--       request = 'launch',
--       name = 'Listen for xdebug',
--       port = '9000',
--       log = true,
--       serverSourceRoot = '/data/home/',
--       localSourceRoot = '/mnt/c/workspace/surala',
--     },
--   }

--   require("nvim-dap-virtual-text").setup()
--   require("dapui").setup()

-- end

-- local function configure_exts()
--   require("nvim-dap-virtual-text").setup {
--     commented = true,
--   }

--   local dap, dapui = require "dap", require "dapui"
--   dapui.setup {} -- use default
--   dap.listeners.after.event_initialized["dapui_config"] = function()
--     dapui.open()
--   end
--   dap.listeners.before.event_terminated["dapui_config"] = function()
--     dapui.close()
--   end
--   dap.listeners.before.event_exited["dapui_config"] = function()
--     dapui.close()
--   end
-- end

-- local function configure_debuggers()
--   -- require("config.dap.lua").setup()
-- end

-- function M.setup()
--   configure() -- Configuration
--   configure_exts() -- Extensions
--   configure_debuggers() -- Debugger
--   require("config.dap.keymaps").setup() -- Keymaps
-- end

-- configure_debuggers()
-- M.setup()


