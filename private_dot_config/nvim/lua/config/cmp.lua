local cmp = require 'cmp'
local luasnip = require("luasnip")

-- local has_words_before = function()
--     local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--     return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- end
--


cmp.setup({
    view = {
        entries = "custom"
    },
    mapping = {
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-y>"] = cmp.mapping.confirm { select = true },

        ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            end
        end, { 'i', 's' }),

        ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            end
        end, { 'i', 's' }),

        ['<C-d>'] = cmp.mapping.scroll_docs( -4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
    },
    -- enabled = function()
    --     return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
    --         or require("cmp_dap").is_dap_buffer()
    -- end,
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },


    completion = {
        completeopt = 'menu,menuone,noinsert'
    },

    sources = {
        {
            name = "lazydev",

            -- set group index to 0 to skip loading LuaLS completions
            group_index = 0,
        },
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'dap' },
        { name = 'luasnip' },
        { name = 'git' },
        { name = 'path' },
    },
})

cmp.setup.filetype({'sql'}, {
    sources = {
        { name = 'vim-dadbod-completion' },
        { name = 'buffer' },
    }
})

require("cmp_git").setup()
