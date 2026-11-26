-- vim.api.nvim_create_autocmd('PackChanged', {
--     callback = function(ev)
--         local name, kind = ev.data.spec.name, ev.data.kind
--         if name == 'nvim-treesitter' and kind == 'update' then
--             if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
--             vim.cmd('TSUpdate')
--         end
--     end
-- })

local languages = {
    "bash",
    "c",
    "cmake",
    "comment",
    "cpp",
    "css",
    "cuda",
    "dockerfile",
    "elixir",
    "gitcommit",
    "html",
    "lua",
    "markdown",
    "python",
    "rust",
    "typst",
    "vimdoc",
}

require('nvim-treesitter').install(languages)

-- local ft_languages = vim.tbl_extend('force', languages, {})
local ft_languages = languages

local function query_status(lang, query_group)
    local tsq = vim.treesitter.query
    local ok, err = pcall(tsq.get, lang, query_group)
    if not ok then
        return false
    elseif not err then
        return false
    else
        return true
    end
end

vim.api.nvim_create_autocmd('FileType', {
    pattern = ft_languages,
    callback = function(event)
        local lang = vim.treesitter.language.get_lang(event.match)
        if not lang then
            return
        end

        -- if query_status(lang, 'highlights') then
        --     vim.treesitter.start()
        -- end

        if query_status(lang, 'folds') then
            vim.wo.foldmethod = 'expr'
            vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        end

        -- if query_status(lang, 'indents') then
        --     vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        -- end
    end,
})

require('nvim-ts-autotag').setup({})

require('treesitter-modules').setup({
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<A-o>",
            node_incremental = "<A-o>",
            scope_incremental = "<A-O>",
            node_decremental = "<A-i>",
        },
    }
})

require('nvim-treesitter-textobjects').setup()
