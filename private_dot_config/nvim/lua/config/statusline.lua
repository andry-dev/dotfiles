local globals = require 'globals'

local M = {}

local function format_marker()
    if not vim.g.disable_autoformat then
        return ""
    else
        return "[F-]"
    end
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
        format_marker(),
        "%=",
        git_head() .. " ",
        "%l,%c ", -- Line, Column
        "%P",
    }
end

return M
