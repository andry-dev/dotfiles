local M = {}

local function global_format_marker()
    if vim.g.disable_autoformat then
        return "[F-]"
    end

    return ""
end

local local_format_marker = [[%{% exists('b:disable_autoformat') ? (b:disable_autoformat ? '[f-]' : '') : '' %}]]

local function git_head()
    local head = vim.call("FugitiveHead")

    if head ~= "" then
        return "[" .. head .. "]"
    else
        return ""
    end
end

local diagnostics = (function()
    if vim.fn.has('nvim-0.12') == 1 then
        return [[%(%{luaeval('(package.loaded[''vim.diagnostic''] and vim.diagnostic.status()) or '''' ')} %)]]
    else
        return ''
    end
end)()


local ruler = [[%{% &ruler ? ( &rulerformat == '' ? '%-14.(%l,%c%V%) %P' : &rulerformat ) : '' %}]]

local busy = (function ()
    if vim.fn.has('nvim-0.12') == 1 then
       return [[%{% &busy > 0 ? '◐ ' : '' %}]]
    else
        return ''
    end
end)()

-- %<%f %h%w%m%r %=%{% &showcmdloc == 'statusline' ? '%-10.S ' : '' %}%{% exists('b:keymap_name') ? '<'..b:keymap_name..'> ' : '' %}%{% &busy > 0 ? '◐ ' : '' %}%(%{luaeval('(package.loaded[''vim.diagnostic''] and vim.diagnostic.status()) or '''' ')} %)%{% &ruler ? ( &rulerformat == '' ? '%-14.(%l,%c%V%) %P' : &rulerformat ) : '' %}

function M.status_line()
    return table.concat {
        "%<%f %h%w%m%r",
        global_format_marker(),
        local_format_marker,
        "%=",
        git_head() .. " ",
        busy,
        diagnostics,
        ruler,
    }
end

return M
