local globals = require 'globals'

local M = {}

local function global_format_marker()
    if vim.g.disable_autoformat then
        return "[F-]"
    end

    return ""
end

local function local_format_marker()
    if vim.b.disable_autoformat then
        return "[f-]"
    end

    return ""
end

local function git_head()
    local head = vim.call("FugitiveHead")

    if head ~= "" then
        return "[" .. head .. "]"
    else
        return ""
    end
end

function M.status_line()
    return table.concat {
        "%<",
        "%f ", -- Current file
        "%h",  -- Help?
        "%m",  -- Modified?
        "%r",  -- RO?
        global_format_marker(),
        local_format_marker(),
        "%=",
        git_head() .. " ",
        "%l,%c ", -- Line, Column
        "%P",
    }
end

return M
