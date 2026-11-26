require('lazydev').setup({
    library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
})

require('blink-cmp').setup {
    signature = { enabled = true },

    completion = {
        documentation = {
            auto_show = true,
        },
    },


    keymap = {
        preset = "default",

        ['<Tab>'] = { 'fallback' },
        ['<S-Tab>'] = { 'fallback' },

        ['<C-l>'] = { 'snippet_forward', 'fallback' },
        ['<C-h>'] = { 'snippet_backward', 'fallback' },
    },

    snippets = {
        preset = "luasnip",
    },

    cmdline = {
        enabled = false,
    },

    sources = {
        default = { "lazydev", "beancount", "lsp", "path", "snippets", "buffer" },

        -- per_filetype = {
        --     lua = { "lazydev", "snippets" },
        -- },

        providers = {
            -- dont show LuaLS require statements when lazydev has items
            lazydev = {
                name = "LazyDev",
                module = "lazydev.integrations.blink",
                score_offset = 100,
            },

            beancount = {
                name = "beancount",
                module = "beancount.completion.blink",
                score_offset = 100,
                opts = {
                    trigger_characters = { ":", "#", "^", '"', " " },
                },
            },

            buffer = {
                score_offset = -100,
            },
        },
    },
}
