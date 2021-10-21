local M = {}

local namespace = vim.api.nvim_create_namespace("focus.nvim")

local default_config = {
    colors = {
        ["red"] = "#FF0000",
        ["green"] = "#00FF00",
        ["blue"] = "#0000FF",
    },
    override_colors = false
}

-- From norcalli
local function nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        vim.api.nvim_command('augroup '..group_name)
        vim.api.nvim_command('autocmd!')
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
            vim.api.nvim_command(command)
        end
        vim.api.nvim_command('augroup END')
    end
end

function M:_unchecked_add_line_hl(hl_group, line_nr)
    vim.api.nvim_buf_add_highlight(0, namespace, hl_group.name, line_nr, 0, -1)
end

function M:add_line_highlight(color, line_nr)
    local hl_group = M:color_to_highlight(color)
    M:_unchecked_add_line_hl(hl_group, line_nr)
end

function M:del_line_highlight(line_nr)
    vim.api.nvim_buf_clear_namespace(0, namespace, line_nr, line_nr + 1)
end

function M:add_range_highlight(color)
    local line_start = vim.api.nvim_buf_get_mark(0, '<')[1]
    local line_end = vim.api.nvim_buf_get_mark(0, '>')[1]

    local hl_group = M:color_to_highlight(color)
    for line = line_start - 1, line_end - 1 do
        M:_unchecked_add_line_hl(hl_group, line)
    end
end

function M:del_range_highlight()
    local line_start = vim.api.nvim_buf_get_mark(0, '<')[1]
    local line_end = vim.api.nvim_buf_get_mark(0, '>')[1]

    for line = line_start - 1, line_end - 1 do
        M:del_line_highlight(line)
    end
end

function M:color_to_highlight(color)
    return { name = "FocusHL_" .. color, color = self.config.colors[color] }
end

function M:setup_highlights()
    for k, _ in pairs(self.config.colors) do
        local highlight_info = M:color_to_highlight(k)
        vim.cmd("highlight " .. highlight_info.name .. " guibg=" .. highlight_info.color)
    end
end

function M:setup_autocmd()
    --[[
    local highlights = {}

    for k, _ in pairs(self.config.colors) do
        local highlight_info = M:color_to_highlight(k)
        vim.list_extend(highlights, {
            {"ColorScheme", "*", "highlight", highlight_info.name, "guibg=" .. highlight_info.color }
        })
    end

    local autocmds = {
        FocusHighlights = highlights
    }

    nvim_create_augroups(autocmds)
    --]]

    vim.cmd([[
        augroup FocusHL
            autocmd!
            autocmd ColorScheme * lua require('focus'):setup_highlights()
        augroup END
    ]])
end

function M:clear_autocmd()
    vim.cmd([[
        augroup FocusHL
            autocmd!
        augroup END
    ]])
end

function M.setup(config)
    M.config = vim.tbl_extend("force", {}, default_config, config or {})

    M:setup_highlights()
    if M.config.override_colors then
        M:setup_autocmd()
    else
        M:clear_autocmd()
    end

    return M
end

return M;
