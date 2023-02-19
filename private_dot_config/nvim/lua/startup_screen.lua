local M = {}

--- Executes a command and returns all the output lines in a table
---
--- @return table
local function exec_cmd(cmd)
    local process = io.popen(cmd,"r")

    local output = {}

    for line in process:lines() do
        table.insert(output, line)
    end

    process:close()

    return output
end

--- Checks whether a string is empty
---
--- @return boolean
local function is_empty(str)
    return str == nil or string.len(str) > 0
end

--- Checks whether nvim is started already inside a project directory
--- In that case we don't need to run FZF
---
--- @return boolean
local function inside_project_dir()
    local cwd = vim.fn.getcwd()

    local projects = exec_cmd('list-prjs')

    local found = false

    for _, v in ipairs(projects) do
        if v == cwd then
            found = true
            break
        end
    end

    -- We are already in a project directory
    return found
end


--- Opens up the startup page
function M.startup()
    local initial_buffer = vim.api.nvim_get_current_buf()

    local initial_buffer_name = vim.api.nvim_buf_get_name(initial_buffer)

    if is_empty(initial_buffer_name) then
        return
    end

    if inside_project_dir() then
        return
    end

    vim.cmd[[P]]

    vim.api.nvim_buf_delete(initial_buffer, {})
end

return M
