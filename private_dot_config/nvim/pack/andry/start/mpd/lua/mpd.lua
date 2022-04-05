local Job = require('plenary.job')

local M = {
    _assigned_buffer = -1,
    _win = -1,
}

local function create_buffer()
    local buf = vim.api.nvim_create_buf(true, true)

    vim.api.nvim_buf_set_name(buf, '[MPD]')
    vim.api.nvim_buf_set_option(buf, 'swapfile', false)
    vim.api.nvim_buf_set_option(buf, 'bufhidden', 'hide')
    vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
    vim.api.nvim_buf_set_option(buf, 'filetype', 'mpd-nvim')
    vim.api.nvim_buf_set_keymap(buf, 'n', 'q', "<cmd>q<cr>", {noremap = true, silent = true})
    vim.api.nvim_buf_set_keymap(buf, 'n', 'p', "<cmd>lua require('mpd'):toggle()<CR>", {noremap = true, silent = true})
    vim.api.nvim_buf_set_keymap(buf, 'n', '<Left>', "<cmd>lua require('mpd'):volume_down()<CR>", {noremap = true, silent = true})
    vim.api.nvim_buf_set_keymap(buf, 'n', '<Right>', "<cmd>lua require('mpd'):volume_up()<CR>", {noremap = true, silent = true})
    vim.api.nvim_buf_set_keymap(buf, 'n', '<', "<cmd>lua require('mpd'):prev()<CR>", {noremap = true, silent = true})
    vim.api.nvim_buf_set_keymap(buf, 'n', '>', "<cmd>lua require('mpd'):next()<CR>", {noremap = true, silent = true})

    local vim_height = vim.api.nvim_eval [[&lines]]
    local vim_width = vim.api.nvim_eval [[&columns]]
    local width = math.floor(vim_width * 0.8) + 5
    local height = math.floor(vim_height * 0.7) + 2
    local col = vim_width * 0.1 - 2
    local row = vim_height * 0.15 - 1

    --[[
    local content_window = vim.api.nvim_open_win(buf, true, {
          relative = 'editor',
          width = width,
          height = height,
          col = col,
          row = row,
          style = 'minimal',
          focusable = false
    })
    --]]

    return buf
end

function M:_get_operations()
    local ret = {}
    for k, _ in pairs(self) do
        if k:sub(1, 1) ~= '_' then
            ret[#ret+1] = k
        end
    end

    return ret
end

function M:_exec_command(cmd)
    if cmd:sub(1, 1) ~= '_' then
        self[cmd](self)
    end
end

function M:_lock_buffer()
    vim.api.nvim_buf_set_option(self._assigned_buffer, 'modifiable', false)
    vim.api.nvim_buf_set_option(self._assigned_buffer, 'readonly', true)
end

function M:_unlock_buffer()
    vim.api.nvim_buf_set_option(self._assigned_buffer, 'modifiable', true)
    vim.api.nvim_buf_set_option(self._assigned_buffer, 'readonly', false)
end

function M:_apply_buf_transform(fn)
    self:_unlock_buffer()
    fn(self._assigned_buffer)
    self:_lock_buffer()
end

function M:_exec(opts)
    opts = opts or {
        args = {},
        on_exit = function() end
    }

    Job:new({
        command = 'mpc',
        args = opts.args,
        on_exit = function(j, result)
            if opts.on_exit ~= nil then
                opts.on_exit(j, result)
            end
            self:status()
        end
    }):start()
end

--[[
function M:close_win()
    local windows = vim.api.nvim_list_wins()

    end
--]]

function M:prev()
    M:_exec({
        args = { 'prev' },
    })
end

function M:next()
    M:_exec({
        args = { 'next' },
    })
end

function M:toggle()
    M:_exec({
        args = { 'toggle' },
    })
end

function M:volume_up()
    M:_exec({
        args = { 'volume', '+5' },
    })
end

function M:volume_down()
    M:_exec({
        args = { 'volume', '-5' },
    })
end

function M:status()
    vim.schedule(function()
        if self._assigned_buffer == -1 or self._assigned_buffer == nil then
            local ret = create_buffer()
            self._assigned_buffer = ret
        end

        vim.api.nvim_exec('b ' .. self._assigned_buffer, false)


        Job:new({
            command = 'mpc',
            -- args = {'-f %artist% - %title%'},
            on_exit = function(j, _)
                vim.schedule(function()
                    self:_apply_buf_transform(function(buf)
                        vim.api.nvim_buf_set_lines(buf, 0, -1, false, j:result())
                    end)
                end)
            end,
        }):start()
    end)
end

return M
