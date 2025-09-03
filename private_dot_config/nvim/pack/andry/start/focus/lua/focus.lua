local M = {}

---@class FocusHL.Config
---@field colors table
---@field override_colors boolean?


local namespace = vim.api.nvim_create_namespace("focus.nvim")


---@type FocusHL.Config
local CONFIG = vim.g.focus_hl

---
---@param hi_group string Highlight group
---@param line_start string|integer[] (row, col)
---@param line_end string|integer[] (row, col)
function M:_unchecked_add_lines_hl(hi_group, line_start, line_end)
    vim.hl.range(0, namespace, hi_group, line_start, line_end, {})
end

function M:del_region_highlight(line_start, line_end)
    vim.api.nvim_buf_clear_namespace(0, namespace, line_start, line_end)
end

function M:add_range_highlight(color, line_start, line_end)
    local line1 = line_start or vim.api.nvim_buf_get_mark(0, '<')
    local line2 = line_end or vim.api.nvim_buf_get_mark(0, '>')

    local hl_group = M:color_to_highlight(color)
    M:_unchecked_add_lines_hl(hl_group.name, { line1[1] - 1, line1[2] - 1 }, { line2[1] - 1, line2[2] })
end

-- function M:del_range_highlight(line_start, line_end)
--     local line1 = vim.api.nvim_buf_get_mark(0, '<')
--     local line2 = vim.api.nvim_buf_get_mark(0, '>')
--
--     M:del_region_highlight(line_start - 1, line_end)
-- end

function M:color_to_highlight(color)
    return { name = "FocusHL_" .. color, color = CONFIG.colors[color] }
end

function M:reload_highlights()
    for k, _ in pairs(CONFIG.colors) do
        local highlight_info = M:color_to_highlight(k)
        vim.api.nvim_set_hl(namespace, highlight_info.name, {
            bg = highlight_info.color
        })
    end
end

return M
