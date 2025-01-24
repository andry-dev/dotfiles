local M = {}

---@param t table
function P(t)
    print(vim.inspect(t))
    return t
end

---@param m string
function R(m)
    package.loaded[m] = nil

    return require(m)
end

---@enum andry.CompletionFramework
M.CompletionFramework = {
    Blink = 0,
    NvimCmp = 1,
    None = 2,
}

return M
