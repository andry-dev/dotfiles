local async = require('plenary.async')

local M = {}

--- Tries to async call VimwikiAll2HTML
--- (doesn't work)
M.compile = async.void(function()
    local output = vim.api.nvim_exec('VimwikiAll2HTML', true)
    vim.split(output, '\n')

    -- print(lines[#lines])
end)

return M
