if vim.g.mason_enabled then
    require("mason-nvim-dap").setup({
        ensure_installed = { 'python', 'codelldb' },
        automatic_installation = false,
    })
end

-- dap.adapters.lldb = {
--     type = "executable",
--     name = "lldb",
--     command = "lldb-vscode",
--     attach = {
--         pidProperty = "pid",
--         pidSelect = "ask"
--     },
--     env = {
--         LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"
--     },
-- }
--
-- dap.adapters.mix_task = {
--     type = "executable",
--     command = globals.elixirls_basepath .. "/release/debugger.sh",
--     args = {}
-- }
--
--
-- dap.configurations.cpp = {
--     {
--         type = "lldb",
--         request = "launch",
--         program = function()
--             return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/')
--         end,
--         cwd = "${workspaceFolder}",
--         name = "lldb"
--     }
-- }
--
-- dap.configurations.c = dap.configurations.cpp
--
-- dap.configurations.elixir = {
--     {
--         type = "mix_task",
--         name = "mix test",
--         task = "test",
--         taskArgs = { "--trace" },
--         request = "launch",
--         startApps = true,
--         projectDir = "${workspaceFolder}",
--         requireFiles = {
--             "test/**/test_helper.exs",
--             "test/**/*_test.exs"
--         }
--     }
-- }
--
--


local dap = require('dap')

local dapui = require('dapui')
dapui.setup()

dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
end

require('nvim-dap-virtual-text').setup({})
require('dap-python').setup('uv', {})

-- return dap
