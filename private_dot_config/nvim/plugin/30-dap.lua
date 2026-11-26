if vim.g.mason_enabled then
    require("mason-nvim-dap").setup({
        ensure_installed = { 'python', 'codelldb' },
        automatic_installation = false,
    })
end


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
