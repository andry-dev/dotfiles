local M = {}

--- Tries to async call Vimwiki2HTML
--- Right now it doesn't work
function M.compile_async()
    local fn = coroutine.create(function()
        vim.cmd[[Vimwiki2HTML]]
    end)

    coroutine.resume(fn)
end

return M
