function L(mode, file)
    if file == nil then
        local buffer = vim.api.nvim_get_current_buf()
        file = vim.api.nvim_buf_get_name(buffer)
    end

    if mode == nil then
        mode = 'open'
    end

    os.execute('L ' .. mode .. ' ' .. file)
end
