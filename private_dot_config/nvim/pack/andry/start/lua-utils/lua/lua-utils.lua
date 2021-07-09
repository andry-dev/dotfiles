local M = {}

function M.merge(table1, table2)
    local result = table1


    for k, v in pairs(table2) do result[k] = v end

    return result
end

return M
