local cmp = require'cmp'

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
    mapping = {
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif has_words_before() then
                cmp.complete()
            elseif vim.fn.pumvisible() == 1 then
                return [[<C-n>]]
            else
                return [[<Tab>]]
            end
        end,

        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif vim.fn.pumvisible() ~= 0 then
                return [[<C-p>]]
            else
                return [[<S-Tab>]]
            end
        end,

        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
    },

    formatting = {
      format = function(entry, vim_item)
        -- fancy icons and a name of kind
        -- vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind

        -- set a name for each source
        vim_item.menu = ({
          buffer = "[Buffer]",
          nvim_lsp = "[LSP]",
          luasnip = "[LuaSnip]",
          nvim_lua = "[Lua]",
          latex_symbols = "[Latex]",
          neorg = "[Neorg]",
        })[entry.source.name]
        return vim_item
      end,
    },

    snippet = {
        expand = function(args)
            require 'luasnip'.lsp_expand(args.body)
        end
    },

    sources = {
        { name = 'path' },
        -- buffer = true,
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'latex_symbols' },
        { name = 'neorg' },
        -- { name = 'nvim_lua'},
        -- { name = 'snippets_nvim'},
        -- { name = 'vim_dadbod_completion'},
    },
})
