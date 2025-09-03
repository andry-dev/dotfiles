if vim.g.focus_hl_loaded then
    return
end

---@type FocusHL.Config
vim.g.focus_hl = vim.g.focus_hl or {
    colors = {
        ["red"] = "#ff0000",
        ["green"] = "#00ff00",
        ["blue"] = "#0000ff",
    },

    override_colors = false
}

vim.api.nvim_create_user_command('FocusHLRemoveRegion', function(opts)
    require('focus'):del_region_highlight(opts.line1 - 1, opts.line2)
end, {
    range = true,
})

vim.api.nvim_create_user_command('FocusHL', function(opts)
    require('focus'):add_range_highlight(opts.args, nil, nil)
end, {
    nargs = 1,
    range = true,
    complete = function(_, _, _)
        return vim.tbl_keys(vim.g.focus_hl.colors)
    end
})

for color, _ in pairs(vim.g.focus_hl.colors) do
    vim.keymap.set('v', '<Plug>FocusHL_' .. color, function()
        local line1 = { vim.fn.line('v'), vim.fn.col('v') }
        local line2 = { vim.fn.line('.'), vim.fn.col('.') }
        require('focus'):add_range_highlight(color, line1, line2)

        -- Hack to exit visual mode
        local esc = vim.api.nvim_replace_termcodes('<esc>', true, false, true)
        vim.api.nvim_feedkeys(esc, 'm', false)
    end)
end

vim.keymap.set('v', '<Plug>FocusHLClear', function()
    local line1 = vim.fn.line('v')
    local line2 = vim.fn.line('.')

    require('focus'):del_region_highlight(line1 - 1, line2)

    -- Hack to exit visual mode
    local esc = vim.api.nvim_replace_termcodes('<esc>', true, false, true)
    vim.api.nvim_feedkeys(esc, 'm', false)
end, {})


vim.g.focus_hl_loaded = true
