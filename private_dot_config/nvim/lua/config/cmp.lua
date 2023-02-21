local cmp = require 'cmp'
local luasnip = require("luasnip")

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
    mapping = {
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end,

        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable( -1) then
                luasnip.jump( -1)
            else
                fallback()
            end
        end,

        ['<C-d>'] = cmp.mapping.scroll_docs( -4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm(),
    },
    --[[
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
          path = "[Path]",
          -- latex_symbols = "[Latex]",
          neorg = "[Neorg]",
          ['vim-dadbod-completion'] = "[DB]",
        })[entry.source.name]
        return vim_item
      end,
    },
    --]]

    enabled = function()
        return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
            or require("cmp_dap").is_dap_buffer()
    end,
    snippet = {
        expand = function(args)
            require 'luasnip'.lsp_expand(args.body)
        end
    },
    view = {
        entries = "native"
    },
    sources = {
        -- buffer = true,
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'orgmode' },
        -- { name = 'latex_symbols' },
        -- { name = 'snippets_nvim'},
        { name = 'vim_dadbod_completion' },
        { name = 'dap' },
    },
})
