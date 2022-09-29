local M = {}

local A1, A2 = 727595, 798405 -- 5^17=D20*A1+A2
local D20, D40 = 1048576, 1099511627776 -- 2^20, 2^40
local X1, X2 = 0, 1

function M.rand()
    local U = X2 * A2
    local V = (X1 * A2 + X2 * A1) % D20
    V = (V * D20 + U) % D40
    X1 = math.floor(V / D20)
    X2 = V - X1 * D20
    return V / D40
end

function M.randint(min, max)
    return math.floor(M.rand() * (max - min)) + min
end

function M.randstr(length)
    local str = ''

    for i = 1, length do
        local uppercase = M.randint(65, 90)
        local lowercase = M.randint(97, 122)

        local choice = M.rand()
        if choice < 0.5 then
            str = str .. string.char(lowercase)
        else
            str = str .. string.char(uppercase)
        end
    end

    return str
end

return M
