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

local dev_lp_cache = nil

function M.is_device_low_powered()
    if dev_lp_cache then
        return dev_lp_cache
    end

    local known_devices = { 'aya', 'shiki' }

    dev_lp_cache = vim.tbl_contains(known_devices, vim.fn.hostname())

    return dev_lp_cache
end

return M
