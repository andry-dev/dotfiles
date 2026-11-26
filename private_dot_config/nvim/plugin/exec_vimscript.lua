vim.api.nvim_create_user_command('Execute', function(data)
    local lines = vim.api.nvim_buf_get_lines(0, data.line1 - 1, data.line2, false)
    vim.api.nvim_exec2(table.concat(lines, '\n'), { output = false })
end, {
    range = true
})

vim.keymap.set('n', '<F1>', function()
    local line = vim.api.nvim_get_current_line()
    vim.api.nvim_exec2(line, { output = false })
end, {
    noremap = true,
})

vim.keymap.set('v', '<F1>', function()
    local line_start = vim.fn.line('v')
    local line_end = vim.api.nvim_win_get_cursor(0)

    local lines = vim.api.nvim_buf_get_lines(0, line_start - 1, line_end[1], false)

    local out = vim.api.nvim_exec2(table.concat(lines, '\n'), { output = true })
    print(out.output)
end, {
    noremap = true,
})
