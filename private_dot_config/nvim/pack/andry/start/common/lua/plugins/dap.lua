dap = require('dap')

dap.adapters.cpp = {
    type = "executable",
    name = "lldb",
    command = "lldb-vscode",
    attach = {
        pidProperty = "pid",
        pidSelect = "ask"
    },
    env = {
        LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"
    },
}

dap.configurations.cpp = {
    {
        type = "cpp",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/')
        end,
        cwd = "${workspaceFolder}",
        name = "lldb"
    }
}

vim.g.dap_virtual_text = true
