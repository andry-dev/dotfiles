local M = {}

local some_var = 0

function M.hi()
    some_var = some_var + 1
    P(some_var)
end

return M
